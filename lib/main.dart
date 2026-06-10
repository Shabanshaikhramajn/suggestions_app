import 'package:chat_app/core/di/service_locator.dart';
import 'package:chat_app/core/routes/router_navigation.dart';
import 'package:chat_app/data/datasource/assistant_remote_data_source.dart';
import 'package:chat_app/presentation/bloc/chat/chat_bloc.dart';
import 'package:chat_app/presentation/bloc/navigation/navigation_bloc.dart';
import 'package:chat_app/presentation/bloc/suggestions/suggestions_bloc.dart';
import 'package:chat_app/presentation/bloc/suggestions/suggestions_event.dart';
import 'package:chat_app/presentation/screen/bottom_sheet_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await init();

  runApp(
    MultiBlocProvider(
      providers: [

        BlocProvider(
          create: (_) => sl<NavigationBloc>(),
        ),

        BlocProvider(
          create: (_) => sl<ChatBloc>(),
        ),

        BlocProvider(
          create: (_) => sl<SuggestionBloc>()
            ..add(SuggestionFetched()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Suggestions App',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      routerConfig: appRouter
    );
  }
}
