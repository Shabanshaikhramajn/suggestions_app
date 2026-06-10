import 'package:chat_app/data/models/chat_model.dart';
import 'package:hive/hive.dart';

abstract class ChatLocalDataSource {
  Future<void> saveMessage(ChatMessageModel message);

  Future<List<ChatMessageModel>> getHistory();

  Future<void> clearHistory();
}

class ChatLocalDataSourceImpl implements ChatLocalDataSource {
  static const boxName = 'chat_history';

  Future<Box<ChatMessageModel>> get _box async =>
      await Hive.openBox<ChatMessageModel>(boxName);

  @override
  Future<void> saveMessage(ChatMessageModel message) async {
    final box = await _box;

    await box.add(message);
  }

  @override
  Future<List<ChatMessageModel>> getHistory() async {
    final box = await _box;

    return box.values.toList();
  }

  @override
  Future<void> clearHistory() async {
    final box = await _box;

    await box.clear();
  }
}