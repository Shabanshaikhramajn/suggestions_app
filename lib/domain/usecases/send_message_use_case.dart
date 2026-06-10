import 'package:chat_app/domain/repository/assistant_repository.dart';

class SendMessageUseCase {
  final AssistantRepository repository;

  SendMessageUseCase(this.repository);

  Future<String> call(String message) {
    return repository.sendMessage(message);
  }
}
