import 'package:chat_app/presentation/bloc/suggestions/suggestions_bloc.dart';
import 'package:chat_app/presentation/bloc/suggestions/suggestions_event.dart';
import 'package:chat_app/presentation/bloc/suggestions/suggestions_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController controller = ScrollController();

  initState() {
    super.initState();

    context.read<SuggestionsBloc>().add(FetchSuggestions());

    controller.addListener(() {
      if (controller.position.pixels >=
          controller.position.maxScrollExtent - 100) {
        context.read<SuggestionsBloc>().add(FetchSuggestions());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("suggestiosn")),
      body: BlocBuilder<SuggestionsBloc, SuggestionsState>(
        builder: (context, state) {
          return ListView.builder(
            controller: controller,
            itemBuilder: (context, index) {
              if (index == state.suggestions.length) {
                return state.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : const SizedBox();
              }

              final item = state.suggestions[index];

              return ListTile(
                title: Text(item.title),
                subtitle: Text(item.description),
              );
            },
          );
        },
      ),
    );
  }
}
