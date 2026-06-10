import 'package:chat_app/data/models/chat_model.dart';
import 'package:equatable/equatable.dart';

class ChatState {
  final List<ChatMessageModel> messages;
  final bool isLoading;
  final String? draftMessage;
  final String? errorMessage;

  const ChatState({
    this.messages = const [],
    this.isLoading = false,
    this.draftMessage,
    this.errorMessage,
  });

  ChatState copyWith({
    List<ChatMessageModel>? messages,
    bool? isLoading,
    String? draftMessage,
    String? errorMessage,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      draftMessage: draftMessage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}