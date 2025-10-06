import 'package:sembast/sembast.dart';
import 'package:sembast_web/sembast_web.dart';
import '../models/story_model.dart';

class LocalDb {
  static final LocalDb _singleton = LocalDb._internal();
  LocalDb._internal();
  factory LocalDb() => _singleton;

  Database? _db;
  final _store = intMapStoreFactory.store('stories');

  /// ✅ Initialize DB only once safely
  Future<void> init() async {
    if (_db != null) return; // Already initialized
    _db = await databaseFactoryWeb.openDatabase('news_portal_app.db');
  }

  Database get db {
    if (_db == null) {
      throw Exception('Database not initialized. Call init() first.');
    }
    return _db!;
  }

  /// ✅ Insert or update a story safely
  Future<void> insertStory(Story story) async {
    if (story.id == null) return;
    await init(); // Ensure DB ready
    await _store.record(story.id!).put(db, story.toJson());
  }

  /// ✅ Get a story by ID (returns null if not found)
  Future<Story?> getStory(int id) async {
    await init(); // Ensure DB ready
    final record = await _store.record(id).get(db);
    if (record == null) return null;
    return Story.fromJson(record);
  }

  /// ✅ Optional: Clear all cached stories (for debugging or refresh)
  Future<void> clearAll() async {
    await init();
    await _store.delete(db);
  }

  /// ✅ Optional: Get all cached stories (for listing offline)
  Future<List<Story>> getAllStories() async {
    await init();
    final records = await _store.find(db);
    return records.map((r) => Story.fromJson(r.value)).toList();
  }
}
