import 'package:sembast/sembast.dart';
import 'package:sembast_web/sembast_web.dart';
import '../models/story_model.dart';

class LocalDb {
  static final LocalDb _singleton = LocalDb._();
  LocalDb._();
  factory LocalDb() => _singleton;

  late Database _db;
  final _store = intMapStoreFactory.store('stories');

  Future<void> init() async {
    _db = await databaseFactoryWeb.openDatabase('news_portal_app.db');
  }

  Future<void> insertStory(Story story) async {
    if (story.id == null) return;
    await _store.record(story.id!).put(_db, story.toJson());
  }

  Future<Story?> getStory(int id) async {
    final record = await _store.record(id).get(_db);
    if (record == null) return null;
    return Story.fromJson(record);
  }
}
