import 'package:chat_app/data/models/chat_model.dart';
import 'package:chat_app/domain/repository/assistant_repository.dart';

class GetHistoryUseCase {
  final AssistantRepository repository;

  GetHistoryUseCase(this.repository);

  Future<List<ChatMessageModel>> call() {
    return repository.getHistory();
  }
}