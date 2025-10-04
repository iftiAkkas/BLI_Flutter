import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/note_provider.dart';
import '../models/note.dart';
import 'package:go_router/go_router.dart';

class EditNotePage extends ConsumerWidget {
  final int noteId;
  const EditNotePage({super.key, required this.noteId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(noteProvider);
    final note = notes.firstWhere((n) => n.id == noteId);

    final titleCtrl = TextEditingController(text: note.title);
    final contentCtrl = TextEditingController(text: note.content);

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Note')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: 'Title')),
            const SizedBox(height: 12),
            TextField(controller: contentCtrl, decoration: const InputDecoration(labelText: 'Content')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final updated = Note(id: note.id, title: titleCtrl.text, content: contentCtrl.text);
                await ref.read(noteProvider.notifier).updateNote(updated);
                if (context.mounted) context.pop();
              },
              child: const Text('Update'),
            )
          ],
        ),
      ),
    );
  }
}
