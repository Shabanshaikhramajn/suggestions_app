import 'package:equatable/equatable.dart';

abstract class SuggestionEvent extends Equatable {
  const SuggestionEvent();

  @override
  List<Object> get props => [];
}

class SuggestionFetched extends SuggestionEvent {}