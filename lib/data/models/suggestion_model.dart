import 'package:chat_app/domain/entity/suggestions_entity.dart';

class SuggestionModel extends Suggestion {
  const SuggestionModel({
    required super.id,
    required super.title,
    required super.description,
  });

  factory SuggestionModel.fromJson(Map<String, dynamic> json) {
    return SuggestionModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }
}
