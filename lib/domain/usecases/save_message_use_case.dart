import 'package:chat_app/data/models/chat_model.dart';
import 'package:chat_app/domain/repository/assistant_repository.dart';

class SaveMessageUseCase {
  final AssistantRepository repository;

  SaveMessageUseCase(this.repository);

  Future<void> call(ChatMessageModel message) {
    return repository.saveMessage(message);
  }
}