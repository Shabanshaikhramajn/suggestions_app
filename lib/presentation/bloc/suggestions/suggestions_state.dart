import 'package:chat_app/data/models/suggestion_model.dart';

class SuggestionsState {
  final List<SuggestionModel> suggestions;
  final bool isLoading;
  final int page;
  final bool hasNext;

  SuggestionsState({
    this.suggestions = const [],
    this.isLoading = false,
    this.page = 1,
    this.hasNext = true,
  });

  // factory SuggestionsState.initial() {
  //   return SuggestionsState(suggestions: [], isLoading: false, error: null);
  // }

  SuggestionsState copyWith({
    List<SuggestionModel>? suggestions,
    bool? isLoading,
    bool? hasNext,
    int? page
  }) {
    return SuggestionsState(
      suggestions: suggestions ?? this.suggestions,
      isLoading: isLoading ?? this.isLoading,
      hasNext: hasNext ?? this.hasNext,
      page: page ?? this.page
    );
  }
}
