import 'package:chat_app/data/datasource/ai_datasource.dart';
import 'package:chat_app/data/datasource/chat_local_data_source.dart';
import 'package:chat_app/data/models/chat_model.dart';
import 'package:chat_app/domain/repository/assistant_repository.dart';
import '../datasource/assistant_remote_data_source.dart';

class AssistantRepositoryImpl
    implements AssistantRepository {

  final GeminiRemoteDataSource remote;
  final ChatLocalDataSource local;

  AssistantRepositoryImpl(
      this.remote,
      this.local,
      );

  @override
  Future<String> sendMessage(
      String message,
      ) {

    return remote.sendMessage(
      message,
    );
  }

  @override
  Future<void> saveMessage(
      ChatMessageModel message,
      ) {

    return local.saveMessage(
      message,
    );
  }

  @override
  Future<List<ChatMessageModel>>
  getHistory() {

    return local.getHistory();
  }

  @override
  Future<void> clearHistory() {

    return local.clearHistory();
  }
}