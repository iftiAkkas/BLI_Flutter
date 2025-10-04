import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/note_provider.dart';
import '../theme_mode.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(noteProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        actions: [
          // Theme toggle button
      
          // Settings button
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: "Settings",
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: notes.isEmpty
          ? const Center(child: Text('No notes yet'))
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (_, i) {
                final note = notes[i];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(
                      note.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(note.content),
                    onTap: () => context.push('/edit/${note.id}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      tooltip: "Delete Note",
                      onPressed: () =>
                          ref.read(noteProvider.notifier).deleteNote(note.id!),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
