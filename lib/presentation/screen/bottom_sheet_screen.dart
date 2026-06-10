import 'package:chat_app/presentation/bloc/chat/chat_event.dart';
import 'package:chat_app/presentation/bloc/chat/chat_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BottomMainScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const BottomMainScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: navigationShell,

      bottomNavigationBar: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: NavigationBar(
            height: 70,
            backgroundColor: Colors.white,
            indicatorColor: Colors.blue.shade50,
            selectedIndex: navigationShell.currentIndex,

            onDestinationSelected: (index) {
              if (index == 2) {
                context.read<ChatBloc>().add(LoadChatHistory());
              }

              navigationShell.goBranch(
                index,
                initialLocation: index == navigationShell.currentIndex,
              );
            },

            destinations: [
              NavigationDestination(
                icon: Icon(
                  Icons.lightbulb_outline,
                  color: navigationShell.currentIndex == 0
                      ? Colors.blue
                      : Colors.grey,
                ),
                selectedIcon: const Icon(Icons.lightbulb, color: Colors.blue),
                label: 'Ideas',
              ),

              NavigationDestination(
                icon: Icon(
                  Icons.chat_bubble_outline,
                  color: navigationShell.currentIndex == 1
                      ? Colors.blue
                      : Colors.grey,
                ),
                selectedIcon: const Icon(Icons.chat, color: Colors.blue),
                label: 'Chat',
              ),

              NavigationDestination(
                icon: Icon(
                  Icons.history_outlined,
                  color: navigationShell.currentIndex == 2
                      ? Colors.blue
                      : Colors.grey,
                ),
                selectedIcon: const Icon(Icons.history, color: Colors.blue),
                label: 'History',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
