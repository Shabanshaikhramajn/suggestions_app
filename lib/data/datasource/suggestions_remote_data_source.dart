import 'package:chat_app/core/commons/app_constants.dart';
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

    final startIndex = (page - 1) * limit;

    if (startIndex >= AppConstants.mockSuggestions.length) {
      return [];
    }

    final endIndex =
    (startIndex + limit).clamp(0, AppConstants.mockSuggestions.length);

    return AppConstants.mockSuggestions
        .sublist(startIndex, endIndex)
        .asMap()
        .entries
        .map(
          (entry) => SuggestionModel(
        id: startIndex + entry.key + 1,
        title: entry.value['title']!,
        description: entry.value['description']!,
      ),
    )
        .toList();
  }
}