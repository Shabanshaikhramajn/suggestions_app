import 'package:chat_app/data/models/chat_model.dart';
import 'package:chat_app/presentation/bloc/chat/chat_event.dart';
import 'package:chat_app/presentation/bloc/chat/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/domain/usecases/send_message_use_case.dart';
import 'package:chat_app/domain/usecases/save_message_use_case.dart';
import 'package:chat_app/domain/usecases/get_history_usecase.dart';
import 'package:uuid/uuid.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final SendMessageUseCase sendMessage;
  final SaveMessageUseCase saveMessage;
  final GetHistoryUseCase getHistory;

  ChatBloc({
    required this.sendMessage,
    required this.saveMessage,
    required this.getHistory,
  }) : super(const ChatState()) {
    on<SendMessage>(_sendMessage);
    on<LoadChatHistory>(_loadHistory);
    on<PrefillMessage>(_prefillMessage);
    on<ClearChat>((event, emit) {
      emit(const ChatState());
    });
    on<OpenConversation>((event, emit) async {
      final history = await getHistory();

      final conversation = history
          .where((msg) => msg.conversationId == event.conversationId)
          .toList();

      emit(
        state.copyWith(
          messages: conversation,
          currentConversationId: event.conversationId,
        ),
      );
    });
    on<StartNewChat>((event, emit) {
      final conversationId = const Uuid().v4();
      emit(
        ChatState(
          messages: [],
          draftMessage: event.message,
          currentConversationId: conversationId,
        ),
      );
    });
  }
  Future<void> _sendMessage(SendMessage event, Emitter<ChatState> emit) async {
    try {
      final userMessage = ChatMessageModel(
        sender: 'user',
        message: event.message,
        timestamp: DateTime.now(),
        conversationId: state.currentConversationId!,
      );

      final updatedMessages = [...state.messages, userMessage];

      emit(state.copyWith(messages: updatedMessages, isLoading: true));

      await saveMessage(userMessage);

      final reply = await sendMessage(event.message);

      final assistantMessage = ChatMessageModel(
        sender: 'assistant',
        message: reply,
        timestamp: DateTime.now(),
        conversationId: state.currentConversationId!,
      );

      await saveMessage(assistantMessage);

      emit(
        state.copyWith(
          messages: [...updatedMessages, assistantMessage],
          isLoading: false,
        ),
      );
    } catch (e) {
      String errorMessage = 'Something went wrong';

      if (e.toString().contains('503')) {
        errorMessage = 'Gemini is busy right now. Please try again.';
      }

      emit(state.copyWith(isLoading: false, errorMessage: errorMessage));
    }
  }

  void _prefillMessage(PrefillMessage event, Emitter<ChatState> emit) {
    emit(
      state.copyWith(
        draftMessage: event.message,
        messages: [],
        errorMessage: null,
      ),
    );
  }

  Future<void> _loadHistory(
    LoadChatHistory event,
    Emitter<ChatState> emit,
  ) async {
    final history = await getHistory();

    emit(state.copyWith(messages: history));
  }
}
