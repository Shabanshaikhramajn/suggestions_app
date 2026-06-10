import 'package:chat_app/data/models/chat_model.dart';
import 'package:equatable/equatable.dart';

class ChatState {
  final List<ChatMessageModel> messages;
  final bool isLoading;
  final String? draftMessage;
  final String? errorMessage;
  final String? currentConversationId;

  const ChatState({
    this.messages = const [],
    this.isLoading = false,
    this.draftMessage,
    this.errorMessage,
    this.currentConversationId,
  });

  ChatState copyWith({
    List<ChatMessageModel>? messages,
    bool? isLoading,
    String? draftMessage,
    String? errorMessage,
    String? currentConversationId,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      draftMessage: draftMessage,
      errorMessage: errorMessage ?? this.errorMessage,
      currentConversationId:
          currentConversationId ?? this.currentConversationId,
    );
  }
}
