import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SupabaseService {
  final SupabaseClient client = SupabaseClient(
    dotenv.env['SUPABASE_URL']!,
    dotenv.env['SUPABASE_ANON_KEY']!,
  );

  Future<void> addMessage(String userMsg, String botMsg) async {
    await client.from('chat_history').insert({
      'user_message': userMsg,
      'bot_message': botMsg,
    });
  }

  Future<List<Map<String, dynamic>>> getChatHistory() async {
    final res = await client.from('chat_history').select().order('created_at');
    return res as List<Map<String, dynamic>>;
  }
}
