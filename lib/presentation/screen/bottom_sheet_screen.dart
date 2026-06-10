
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
class BottomMainScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const BottomMainScreen({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return
      // BlocListener<BottomNavCubit, int>(
      //   listener: (_, index) {
      //     navigationShell.goBranch(index);
      //   },
      // child:
      Scaffold(
        body: navigationShell,

        bottomNavigationBar: NavigationBar(
          selectedIndex: navigationShell.currentIndex,

          onDestinationSelected: (index) {
            navigationShell.goBranch(
              index,

              initialLocation:
              index == navigationShell.currentIndex,
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

  }
}

