import 'package:chat_app/data/datasource/chat_local_datasource.dart';
import 'package:chat_app/data/models/chat_model.dart';
import 'package:hive/hive.dart';

class ChatLocalDataSourceImpl implements ChatLocalDataSource {
  final Box<ChatMessageModel> box;

  ChatLocalDataSourceImpl(this.box);

  @override
  Future<void> saveMessage(ChatMessageModel message) async {
    await box.add(message);
  }

  @override
  Future<List<ChatMessageModel>> getHistory() async {
    return box.values.toList();
  }

  @override
  Future<void> clearHistory() async {
    await box.clear();
  }
}
