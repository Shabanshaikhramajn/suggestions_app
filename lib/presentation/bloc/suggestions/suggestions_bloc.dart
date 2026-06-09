import 'package:chat_app/domain/usecases/suggestions_usecase.dart';
import 'package:chat_app/presentation/bloc/suggestions/suggestions_event.dart';
import 'package:chat_app/presentation/bloc/suggestions/suggestions_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuggestionBloc
    extends Bloc<SuggestionEvent, SuggestionState> {

  final GetSuggestions getSuggestions;

  int _page = 1;
  final int _limit = 10;

  SuggestionBloc(this.getSuggestions)
      : super(const SuggestionState()) {

    on<SuggestionFetched>(_onFetched);
  }

  Future<void> _onFetched(
    SuggestionFetched event,
    Emitter<SuggestionState> emit,
  ) async {

    if (state.hasReachedMax) return;

    try {
      if (state.status == SuggestionStatus.initial) {

        emit(
          state.copyWith(
            status: SuggestionStatus.loading,
          ),
        );

        final suggestions = await getSuggestions(
          page: _page,
          limit: _limit,
        );

        _page++;

        emit(
          state.copyWith(
            status: SuggestionStatus.success,
            suggestions: suggestions,
            hasReachedMax: suggestions.length < _limit,
          ),
        );
      } else {

        final suggestions = await getSuggestions(
          page: _page,
          limit: _limit,
        );

        _page++;

        emit(
          state.copyWith(
            status: SuggestionStatus.success,
            suggestions: [
              ...state.suggestions,
              ...suggestions,
            ],
            hasReachedMax: suggestions.length < _limit,
          ),
        );
      }
    } catch (_) {

      emit(
        state.copyWith(
          status: SuggestionStatus.failure,
        ),
      );
    }
  }
}