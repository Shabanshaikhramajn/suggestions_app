import 'package:chat_app/presentation/bloc/navigation/navigation_bloc.dart';
import 'package:chat_app/presentation/bloc/navigation/navigation_event.dart';
import 'package:chat_app/presentation/bloc/navigation/navigation_state.dart';
import 'package:chat_app/presentation/screen/chat_screen.dart';
import 'package:chat_app/presentation/screen/history_screen.dart';
import 'package:chat_app/presentation/screen/suggestion_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final screens = [
      const SuggestionPage(),
      const ChatScreen(),
      const HistoryScreen(),
    ];

    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {

        return Scaffold(
          body: IndexedStack(
            index: state.selectedIndex,
            children: screens,
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: state.selectedIndex,
            onDestinationSelected: (index) {
              context.read<NavigationBloc>().add(
                    NavigationTabChanged(index),
                  );
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.lightbulb_outline),
                selectedIcon: Icon(Icons.lightbulb),
                label: 'Suggestions',
              ),
              NavigationDestination(
                icon: Icon(Icons.chat_bubble_outline),
                selectedIcon: Icon(Icons.chat),
                label: 'Chat',
              ),
              NavigationDestination(
                icon: Icon(Icons.history),
                selectedIcon: Icon(Icons.history),
                label: 'History',
              ),
            ],
          ),
        );
      },
    );
  }
}