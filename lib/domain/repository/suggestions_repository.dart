import 'package:chat_app/domain/entity/suggestions_entity.dart';

abstract class SuggestionRepository {
  Future<List<Suggestion>> getSuggestions({
    required int page,
    required int limit,
  });
}