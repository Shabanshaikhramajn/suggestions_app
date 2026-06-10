import 'package:chat_app/core/routes/app_routes.dart';
import 'package:chat_app/presentation/screen/bottom_sheet_screen.dart';
import 'package:chat_app/presentation/screen/chat_screen.dart';
import 'package:chat_app/presentation/screen/history_screen.dart';
import 'package:chat_app/presentation/screen/suggestion_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';



final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.suggestions,

  routes: [
    StatefulShellRoute.indexedStack(
      builder: (
          context,
          state,
          navigationShell,
          ) {
        return BottomMainScreen (
          navigationShell: navigationShell,
        );
      },

      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.suggestions,
              builder: (context, state) {
                return const SuggestionScreen();
              },
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.chat,
              builder: (context, state) {
                final initialMessage =
                state.extra as String?;

                return ChatScreen(
                  initialMessage: initialMessage,
                );
              },
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.history,
              builder: (context, state) {
                return const HistoryScreen();
              },
            ),
          ],
        ),
      ],
    ),
  ],
);