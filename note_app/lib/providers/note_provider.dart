import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../models/note.dart';

final noteProvider = StateNotifierProvider<NoteNotifier, List<Note>>((ref) {
  return NoteNotifier();
});

class NoteNotifier extends StateNotifier<List<Note>> {
  late Database _db;
  final _store = intMapStoreFactory.store('notes');

  NoteNotifier() : super([]) {
    _init();
  }

  Future<void> _init() async {
    if (kIsWeb) {
      // ✅ Web uses databaseFactoryWeb
      _db = await databaseFactoryWeb.openDatabase('notes.db');
    } else {
      // ✅ Mobile/Desktop
      final dir = await getApplicationDocumentsDirectory();
      await dir.create(recursive: true);
      final dbPath = '${dir.path}/notes.db';
      _db = await databaseFactoryIo.openDatabase(dbPath);
    }

    await loadNotes();
  }

  Future<void> loadNotes() async {
    final snapshots = await _store.find(_db);
    state = snapshots
        .map((snap) => Note.fromMap({...snap.value, 'id': snap.key}))
        .toList();
  }

  Future<void> addNote(Note note) async {
    final key = await _store.add(_db, note.toMap());
    state = [...state, note..id = key];
  }

  Future<void> updateNote(Note note) async {
    await _store.record(note.id!).put(_db, note.toMap());
    await loadNotes();
  }

  Future<void> deleteNote(int id) async {
    await _store.record(id).delete(_db);
    await loadNotes();
  }
}
