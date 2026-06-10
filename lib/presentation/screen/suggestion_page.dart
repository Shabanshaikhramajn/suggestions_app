import 'package:chat_app/core/routes/app_routes.dart';
import 'package:chat_app/presentation/bloc/chat/chat_bloc.dart';
import 'package:chat_app/presentation/bloc/chat/chat_event.dart';
import 'package:chat_app/presentation/bloc/suggestions/suggestions_bloc.dart';
import 'package:chat_app/presentation/bloc/suggestions/suggestions_event.dart';
import 'package:chat_app/presentation/bloc/suggestions/suggestions_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SuggestionScreen extends StatefulWidget {
  const SuggestionScreen({super.key});

  @override
  State<SuggestionScreen> createState() =>
      _SuggestionScreenState();
}

class _SuggestionScreenState
    extends State<SuggestionScreen> {

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

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
                  context.read<ChatBloc>().add(
                    StartNewChat(suggestion.title),
                  );
                  // Navigate to Chat Screen
                  // context.read<ChatBloc>().add(
                  //   PrefillMessage(
                  //     suggestion.title,
                  //   ),
                  // );

                  context.go(
                     AppRoutes.chat,
                    extra: suggestion.title,
                  );
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