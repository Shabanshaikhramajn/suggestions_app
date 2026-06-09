class ChatMessageModel {
  final String sender;
  final String message;

  ChatMessageModel({
    required this.sender,
    required this.message,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      sender: json['sender'],
      message: json['message'],
    );
  }
}
