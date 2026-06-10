import 'package:hive/hive.dart';

part 'chat_model.g.dart';

@HiveType(typeId: 0)
class ChatMessageModel {

  @HiveField(0)
  final String sender;

  @HiveField(1)
  final String message;

  @HiveField(2)
  final DateTime timestamp;

  ChatMessageModel({
    required this.sender,
    required this.message,
    required this.timestamp,
  });
}