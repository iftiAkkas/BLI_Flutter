import 'package:sembast/sembast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import '../models/chat_message.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sembast_web/sembast_web.dart';
import 'package:sembast/sembast_io.dart';

class ChatRepository {
  static const String dbName = 'chats.db';
  final Database _database;
  final StoreRef<String, Map<String, dynamic>> _store;

  ChatRepository._(this._database) : _store = stringMapStoreFactory.store('chats');

  static Future<ChatRepository> create() async {
    late final Database db;
    
    if (kIsWeb) {
      final factory = databaseFactoryWeb;
      db = await factory.openDatabase(dbName);
    } else {
      final appDir = await getApplicationDocumentsDirectory();
      final dbPath = join(appDir.path, dbName);
      db = await databaseFactoryIo.openDatabase(dbPath);
    }
    
    return ChatRepository._(db);
  }

  Future<void> saveMessage(ChatMessage message) async {
    try {
      await _store.record(message.id).put(
        _database,
        message.toJson(),
        merge: true,
      );
    } catch (e) {
      throw DatabaseException('Failed to save message: $e');
    }
  }

  Future<List<ChatMessage>> getAllMessages() async {
    try {
      final records = await _store.find(_database);
      return records
          .map((record) => ChatMessage.fromJson(record.value))
          .toList()
        ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
    } catch (e) {
      throw DatabaseException('Failed to fetch messages: $e');
    }
  }
}

class DatabaseException implements Exception {
  final String message;
  DatabaseException(this.message);

  @override
  String toString() => message;
}