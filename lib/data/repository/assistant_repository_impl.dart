import 'package:chat_app/data/models/chat_model.dart';
import 'package:chat_app/domain/repository/assistant_repository.dart';
import '../datasource/assistant_remote_data_source.dart';

class AssistantRepositoryImpl implements AssistantRepository {
  final AssistantRemoteDataSource remote;

  AssistantRepositoryImpl(this.remote);

  @override
  Future<Map<String, dynamic>> getSuggestions(int page, int limit) async {
    return remote.getSuggestions(page, limit);
  }

  @override
  Future<String> sendMessage(String message) {
    return remote.sendMessage(message);
  }

  @override
  Future<List<ChatMessageModel>> getHistory() {
    return remote.getChatHistory();
  }
}
