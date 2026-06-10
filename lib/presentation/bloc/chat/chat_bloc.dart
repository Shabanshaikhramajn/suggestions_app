import 'package:chat_app/core/commons/app_constants.dart';
import 'package:chat_app/data/models/chat_model.dart';
import 'package:chat_app/presentation/bloc/chat/chat_event.dart';
import 'package:chat_app/presentation/bloc/chat/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/domain/usecases/send_message_use_case.dart';
import 'package:chat_app/domain/usecases/save_message_use_case.dart';
import 'package:chat_app/domain/usecases/get_history_usecase.dart';
import 'package:google_generative_ai/google_generative_ai.dart';


class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final SendMessageUseCase sendMessage;
  final SaveMessageUseCase saveMessage;
  final GetHistoryUseCase getHistory;

  ChatBloc({
    required this.sendMessage,
    required this.saveMessage,
    required this.getHistory,
  }): super(const ChatState()) {
    on<SendMessage>(_sendMessage);
    on<LoadChatHistory>(_loadHistory);
    on<PrefillMessage>(_prefillMessage);
    on<ClearChat>((event, emit) {
      emit(const ChatState());
    });
    on<StartNewChat>((event, emit) {
      emit(
        ChatState(
          messages: [],
          draftMessage: event.message,
        ),
      );
    });
  }
  Future<void> _sendMessage(
      SendMessage event,
      Emitter<ChatState> emit,
      ) async {
    try {
      final userMessage = ChatMessageModel(
        sender: 'user',
        message: event.message,
        timestamp: DateTime.now(),
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

      await saveMessage(userMessage);

      final reply = await sendMessage(
        event.message,
      );

      final assistantMessage = ChatMessageModel(
        sender: 'assistant',
        message: reply,
        timestamp: DateTime.now(),
      );

      await saveMessage(assistantMessage);

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
        messages: [],
        errorMessage: null
      ),
    );
  }

  Future<void> _loadHistory(
      LoadChatHistory event,
      Emitter<ChatState> emit,
      ) async {
    final history = await getHistory();

    emit(
      state.copyWith(
        messages: history,
      ),
    );
  }



}
