import 'package:equatable/equatable.dart';
import 'package:chat_app/domain/entity/suggestions_entity.dart';

enum SuggestionStatus { initial, loading, success, failure }

class SuggestionState extends Equatable {
  final SuggestionStatus status;
  final List<Suggestion> suggestions;
  final bool hasReachedMax;

  const SuggestionState({
    this.status = SuggestionStatus.initial,
    this.suggestions = const [],
    this.hasReachedMax = false,
  });

  SuggestionState copyWith({
    SuggestionStatus? status,
    List<Suggestion>? suggestions,
    bool? hasReachedMax,
  }) {
    return SuggestionState(
      status: status ?? this.status,
      suggestions: suggestions ?? this.suggestions,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, suggestions, hasReachedMax];
}
