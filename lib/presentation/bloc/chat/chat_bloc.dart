import 'package:chat_app/data/models/chat_model.dart';
import 'package:chat_app/presentation/bloc/chat/chat_event.dart';
import 'package:chat_app/presentation/bloc/chat/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(const ChatState()) {
    on<SendMessage>(_sendMessage);
    on<LoadChatHistory>(_loadHistory);
    on<PrefillMessage>(_prefillMessage);
  }
  Future<void> _sendMessage(
      SendMessage event,
      Emitter<ChatState> emit,
      ) async {
    try {
      final userMessage = ChatMessageModel(
        sender: 'user',
        message: event.message,
      );

      final updatedMessages = [
        ...state.messages,
        userMessage,
      ];

      emit(
        state.copyWith(
          messages: updatedMessages,
          isLoading: true,
        ),
      );

      await Future.delayed(
        const Duration(seconds: 1),
      );

      final assistantMessage = ChatMessageModel(
        sender: 'assistant',
        message: _generateReply(event.message),
      );

      emit(
        state.copyWith(
          messages: [
            ...updatedMessages,
            assistantMessage,
          ],
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _prefillMessage(
      PrefillMessage event,
      Emitter<ChatState> emit,
      ) {
    emit(
      state.copyWith(
        draftMessage: event.message,
      ),
    );
  }

  Future<void> _loadHistory(
    LoadChatHistory event,
    Emitter<ChatState> emit,
  ) async {
    emit(state.copyWith(messages: []));
  }

  String _generateReply(String message) {
    final text = message.toLowerCase();

    if (text.contains('flutter')) {
      return 'Flutter is an oper-source UI toolkit developed by google';
    }
    if (text.contains('dart')) {
      return 'Dart is the programming language used by flutter';
    }

    return 'you said : $message';
  }
}
