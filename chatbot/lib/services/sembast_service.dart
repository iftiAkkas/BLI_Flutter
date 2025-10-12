import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../models/chat_message.dart';

class SembastService {
  Database? _db;
  final _store = intMapStoreFactory.store('chat');

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    await Directory(dir.path).create(recursive: true);
    _db = await databaseFactoryIo.openDatabase('${dir.path}/chat.db');
  }

  Future<void> saveMessage(ChatMessage msg) async {
    await _store.add(_db!, msg.toMap());
  }

  Future<List<ChatMessage>> getMessages() async {
    final records = await _store.find(_db!);
    return records.map((r) => ChatMessage.fromMap(r.value)).toList();
  }
}
