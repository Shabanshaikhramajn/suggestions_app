import 'package:chat_app/data/models/chat_model.dart';
import 'package:chat_app/presentation/bloc/chat/chat_event.dart';
import 'package:chat_app/presentation/bloc/chat/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(const ChatState()) {
    on<SendMessage>(_sendMessage);
    on<LoadChatHistory>(_loadHistory);
  }

  Future<void> _sendMessage(SendMessage event, Emitter<ChatState> emit) async {
    try {
      final userMessage = ChatMessageModel(
        sender: 'user',
        message: event.message,
      );

      emit(
        state.copyWith(
          messages: [...state.messages, userMessage],
          isLoading: true,
        ),
      );

      await Future.delayed(const Duration(seconds: 1));

      String reply = _generateReply(event.message);

      final assistantMessage = ChatMessageModel(
        sender: 'assistant',
        message: reply,
      );

      emit(
        state.copyWith(
          messages: [...state.messages, assistantMessage],
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
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
