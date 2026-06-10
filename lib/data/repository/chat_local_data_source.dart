import 'package:chat_app/data/models/chat_model.dart';

abstract class ChatLocalDataSource {
  Future<void> saveMessage(ChatMessageModel message);

  Future<List<ChatMessageModel>> getHistory();

  Future<void> clearHistory();
}
