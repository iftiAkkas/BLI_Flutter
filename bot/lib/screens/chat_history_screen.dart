import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/chat_message.dart';
import '../providers/chat_provider.dart';
import 'chat_screen.dart';

class ChatHistoryScreen extends ConsumerWidget {
  const ChatHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(chatProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat History"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: "New Chat",
            onPressed: () {
              ref.read(chatProvider.notifier).clearMessages();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ChatScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: chatState.when(
        data: (messages) {
          if (messages.isEmpty) {
            return const Center(child: Text("No chats yet"));
          }
          return ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final msg = messages[index];
              return ListTile(
                title: Text(
                  msg.content.length > 40
                      ? "${msg.content.substring(0, 40)}..."
                      : msg.content,
                ),
                subtitle: Text(
                  "${msg.sender} • ${msg.timestamp.toLocal()}",
                  style: const TextStyle(fontSize: 12),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(resumeMessages: messages),
                    ),
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text("Error: $err")),
      ),
    );
  }
}
