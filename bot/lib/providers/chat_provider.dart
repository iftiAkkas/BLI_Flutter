import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/chat_message.dart';
import '../services/chatbot_service.dart';
import '../repositories/chat_repository.dart';

final chatbotServiceProvider = Provider((ref) => ChatbotService());

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  throw UnimplementedError('Initialize in main.dart');
});

final chatProvider =
    StateNotifierProvider<ChatNotifier, AsyncValue<List<ChatMessage>>>(
  (ref) => ChatNotifier(
    ref.watch(chatbotServiceProvider),
    ref.watch(chatRepositoryProvider),
  ),
);

class ChatNotifier extends StateNotifier<AsyncValue<List<ChatMessage>>> {
  final ChatbotService _chatService;
  final ChatRepository _repository;
  final List<ChatMessage> _messages = [];

  ChatNotifier(this._chatService, this._repository)
      : super(const AsyncValue.loading()) {
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    try {
      final loaded = await _repository.getAllMessages();
      _messages.addAll(loaded);
      state = AsyncValue.data(List.unmodifiable(_messages));
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty) return;

    try {
      final userMessage = ChatMessage(
        sender: 'user',
        content: content,
        timestamp: DateTime.now(),
      );

      _messages.add(userMessage);
      state = AsyncValue.data(List.unmodifiable(_messages));
      await _repository.saveMessage(userMessage);

      final response = await _chatService.getResponse(content, _messages);

      final botMessage = ChatMessage(
        sender: 'bot',
        content: response,
        timestamp: DateTime.now(),
      );

      _messages.add(botMessage);
      state = AsyncValue.data(List.unmodifiable(_messages));
      await _repository.saveMessage(botMessage);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  void resumeChat(List<ChatMessage> messages) {
    _messages.addAll(messages);
    state = AsyncValue.data(List.unmodifiable(_messages));
  }

  void clearMessages() {
    _messages.clear();
    state = const AsyncValue.data([]);
  }

  List<ChatMessage> getMessages() => List.unmodifiable(_messages);
}
