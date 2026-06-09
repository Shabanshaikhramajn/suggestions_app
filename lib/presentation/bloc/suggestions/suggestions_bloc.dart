import 'package:chat_app/data/models/suggestion_model.dart';
import 'package:chat_app/domain/repository/assistant_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/presentation/bloc/suggestions/suggestions_event.dart';
import 'package:chat_app/presentation/bloc/suggestions/suggestions_state.dart';

class SuggestionsBloc extends Bloc<FetchSuggestions, SuggestionsState> {
  final AssistantRepository repository;

  SuggestionsBloc(this.repository) : super(SuggestionsState()) {
    on<FetchSuggestions>(_fetch);
  }

  Future<void> _fetch(
    FetchSuggestions event,
    Emitter<SuggestionsState> emit,
  ) async {
    if (!state.hasNext || state.isLoading) return;

    emit(state.copyWith(isLoading: true));
    final response = await repository.getSuggestions(state.page, 10);

    final list = (response['data'] as List)
        .map((e) => SuggestionModel.fromJson(e))
        .toList();

    emit(
      state.copyWith(
        suggestions: [...state.suggestions, ...list],
        hasNext: response['pagination']['has_next'],
        page: state.page + 1,
        isLoading: false,
      ),
    );
  }
}
