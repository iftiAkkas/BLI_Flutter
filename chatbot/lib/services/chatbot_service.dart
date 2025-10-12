import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatbotService {
  final String apiUrl = dotenv.env['LM_API_URL'] ?? "";

  Future<String> getResponse(String userMessage) async {
    if (apiUrl.isEmpty) {
      // If API URL not configured yet
      return "(LM API not connected)";
    }

    final body = jsonEncode({
      "model": "qwen-2.5",
      "messages": [
        {"role": "user", "content": userMessage}
      ]
    });

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'] ?? "No response";
    } else {
      throw Exception("Error: ${response.body}");
    }
  }
}
