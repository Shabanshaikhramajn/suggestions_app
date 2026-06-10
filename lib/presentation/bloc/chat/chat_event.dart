import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class SendMessage extends ChatEvent {
  final String message;
  const SendMessage(this.message);

  @override
  List<Object?> get props => [message];
}

class LoadChatHistory extends ChatEvent {}


class PrefillMessage extends ChatEvent {
  final String message;

  const PrefillMessage(this.message);
}
class ClearDraft extends ChatEvent {}

class ClearChat extends ChatEvent {}

class StartNewChat extends ChatEvent {
  final String message;

  const StartNewChat(this.message);
}