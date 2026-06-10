import 'package:chat_app/data/models/chat_model.dart';

abstract class AssistantRepository {
  Future<String> sendMessage(String message);

  Future<void> saveMessage(ChatMessageModel message);

  Future<List<ChatMessageModel>> getHistory();

  Future<void> clearHistory();
}
