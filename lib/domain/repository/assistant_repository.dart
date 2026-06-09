import 'package:chat_app/data/models/chat_model.dart';

abstract class AssistantRepository {
  Future<Map<String, dynamic>> getSuggestions(int page, int limit);

  //send message
  Future<String> sendMessage(String message);

  //get history
  Future<List<ChatMessageModel>> getHistory();
}
