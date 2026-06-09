import 'package:chat_app/data/models/suggestion_model.dart';

abstract class SuggestionRemoteDataSource {
  Future<List<SuggestionModel>> getSuggestions({
    required int page,
    required int limit,
  });
}

class SuggestionRemoteDataSourceImpl
    implements SuggestionRemoteDataSource {

  @override
  Future<List<SuggestionModel>> getSuggestions({
    required int page,
    required int limit,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    return List.generate(limit, (index) {
      final id = ((page - 1) * limit) + index + 1;

      return SuggestionModel(
        id: id,
        title: 'Suggestion $id',
        description: 'Description for suggestion $id',
      );
    });
  }
}