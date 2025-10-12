import 'dart:convert';
import 'dart:math' show min;
import 'package:http/http.dart' as http;
import '../models/chat_message.dart';

class ChatbotService {
  static const String _baseUrl = 'http://127.0.0.1:1234';

  Future<void> testConnection() async {
    try {
      print('Testing LLM server connection...');
      final response = await http.get(Uri.parse('$_baseUrl/v1/models'));
      print('Server response: ${response.statusCode}');
      
      if (response.statusCode != 200) {
        throw Exception('Server returned ${response.statusCode}');
      }
      
      final data = jsonDecode(response.body);
      print('Available models: ${data.toString()}');
    } catch (e) {
      print('Connection test failed: $e');
      throw Exception('Failed to connect to LLM server: $e');
    }
  }

  Future<String> getResponse(String message, List<ChatMessage> previousMessages) async {
    try {
      print('Getting response with ${previousMessages.length} previous messages');
      
      final messages = <Map<String, String>>[
        {'role': 'system', 'content': 'You are a helpful assistant.'}
      ];

      // Add previous messages to maintain context
      for (final msg in previousMessages.take(10)) {
        messages.add({
          'role': msg.sender == 'user' ? 'user' : 'assistant',
          'content': msg.content,
        });
      }

      messages.add({'role': 'user', 'content': message});

      print('Sending request with ${messages.length} messages');

      final response = await http.post(
        Uri.parse('$_baseUrl/v1/chat/completions'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'messages': messages,
          'model': 'qwen2.5-0.5b-instruct',
          'temperature': 0.7,
          'max_tokens': 2000,
          'stream': false,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final content = data['choices'][0]['message']['content'] as String?;
        
        if (content == null || content.isEmpty) {
          print('Received empty response from LLM');
          return 'Sorry, I received an empty response. Please try again.';
        }
        
        print('Received response: ${content.substring(0, min(50, content.length))}...');
        return content;
      } else {
        print('Error response: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to get response: ${response.statusCode}');
      }
    } catch (e) {
      print('Error getting response: $e');
      throw Exception('Failed to communicate with LLM: $e');
    }
  }
}

