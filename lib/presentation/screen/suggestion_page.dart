import 'package:chat_app/presentation/bloc/suggestions/suggestions_bloc.dart';
import 'package:chat_app/presentation/bloc/suggestions/suggestions_event.dart';
import 'package:chat_app/presentation/bloc/suggestions/suggestions_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuggestionPage extends StatefulWidget {
  const SuggestionPage({super.key});

  @override
  State<SuggestionPage> createState() =>
      _SuggestionPageState();
}

class _SuggestionPageState
    extends State<SuggestionPage> {

  final _scrollController = ScrollController();

  @override
  void initState() {

    context.read<SuggestionBloc>()
      .add(SuggestionFetched());

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {

      context.read<SuggestionBloc>()
        .add(SuggestionFetched());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suggestions'),
      ),
      body: BlocBuilder<
          SuggestionBloc,
          SuggestionState>(
        builder: (context, state) {

          if (state.status ==
              SuggestionStatus.loading &&
              state.suggestions.isEmpty) {

            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            controller: _scrollController,
            itemCount: state.hasReachedMax
                ? state.suggestions.length
                : state.suggestions.length + 1,
            itemBuilder: (context, index) {

              if (index >=
                  state.suggestions.length) {

                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child:
                        CircularProgressIndicator(),
                  ),
                );
              }

              final suggestion =
                  state.suggestions[index];

              return ListTile(
                title: Text(suggestion.title),
                subtitle: Text(
                  suggestion.description,
                ),
                onTap: () {
                  // Navigate to Chat Screen
                },
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}