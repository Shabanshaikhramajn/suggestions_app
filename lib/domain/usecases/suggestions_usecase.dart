import 'package:chat_app/domain/entity/suggestions_entity.dart';
import 'package:chat_app/domain/repository/suggestions_repository.dart';

class GetSuggestions {
  final SuggestionRepository repository;

  GetSuggestions(this.repository);

  Future<List<Suggestion>> call({required int page, required int limit}) {
    return repository.getSuggestions(page: page, limit: limit);
  }
}
