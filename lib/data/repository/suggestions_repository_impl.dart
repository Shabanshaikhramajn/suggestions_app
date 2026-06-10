import 'package:chat_app/data/datasource/suggestions_remote_data_source.dart';
import 'package:chat_app/domain/entity/suggestions_entity.dart';
import 'package:chat_app/domain/repository/suggestions_repository.dart';

class SuggestionRepositoryImpl implements SuggestionRepository {
  final SuggestionRemoteDataSource remoteDataSource;

  SuggestionRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Suggestion>> getSuggestions({
    required int page,
    required int limit,
  }) {
    return remoteDataSource.getSuggestions(page: page, limit: limit);
  }
}
