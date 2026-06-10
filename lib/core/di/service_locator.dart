import 'package:chat_app/core/commons/app_constants.dart';
import 'package:chat_app/core/network/api_client.dart';
import 'package:chat_app/data/datasource/ai_datasource.dart';
import 'package:chat_app/data/datasource/ai_remote_data_sourceimpl.dart';
import 'package:chat_app/data/datasource/assistant_remote_datasource.dart';
import 'package:chat_app/data/datasource/chat_local_datasource.dart';
import 'package:chat_app/data/datasource/suggestions_remote_data_source.dart';
import 'package:chat_app/data/repository/assistant_repository_impl.dart';
import 'package:chat_app/data/repository/suggestions_repository_impl.dart';
import 'package:chat_app/domain/repository/assistant_repository.dart';
import 'package:chat_app/domain/repository/suggestions_repository.dart';
import 'package:chat_app/domain/usecases/get_history_usecase.dart';
import 'package:chat_app/domain/usecases/save_message_use_case.dart';
import 'package:chat_app/domain/usecases/send_message_use_case.dart';
import 'package:chat_app/domain/usecases/suggestions_usecase.dart';
import 'package:chat_app/presentation/bloc/chat/chat_bloc.dart';
import 'package:chat_app/presentation/bloc/navigation/navigation_bloc.dart';
import 'package:chat_app/presentation/bloc/suggestions/suggestions_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

final sl = GetIt.instance;

Future<void> init() async {

  /// Blocs
  sl.registerFactory(
        () => NavigationBloc(),
  );

  /// UseCases
  sl.registerLazySingleton(
        () => SendMessageUseCase(sl()),
  );

  sl.registerLazySingleton(
        () => SaveMessageUseCase(sl()),
  );

  sl.registerLazySingleton(
        () => GetHistoryUseCase(sl()),
  );

  sl.registerLazySingleton(
        () => GetSuggestions(sl()),
  );

  sl.registerFactory(
        () => ChatBloc(
      sendMessage: sl(),
      saveMessage: sl(),
      getHistory: sl(),
    ),
  );

  sl.registerLazySingleton(
        () => GenerativeModel(
      model: 'gemini-flash-latest',
      apiKey: AppConstants.Apikey,
    ),
  );

  sl.registerLazySingleton<GeminiRemoteDataSource>(
        () => GeminiRemoteDataSourceImpl(
      sl(),
    ),
  );

  sl.registerFactory(
        () => SuggestionBloc(
      sl(),
    ),
  );

  // /// UseCases
  // sl.registerLazySingleton(
  //       () => GetSuggestions(
  //     sl(),
  //   ),
  // );

  sl.registerLazySingleton<ChatLocalDataSource>(
        () => ChatLocalDataSourceImpl(),
  );

  /// Repository
  sl.registerLazySingleton<SuggestionRepository>(
    () => SuggestionRepositoryImpl(
      sl(),
    ),
  );

  sl.registerLazySingleton<AssistantRepository>(
        () => AssistantRepositoryImpl(
      sl(),
          sl()
    ),
  );

  /// DataSource
  sl.registerLazySingleton<SuggestionRemoteDataSource>(
    () => SuggestionRemoteDataSourceImpl(),
  );

  sl.registerLazySingleton(
        () => AssistantRemoteDataSource(
      sl(),
    ),
  );

  /// Core
  sl.registerLazySingleton(
        () => ApiClient(),
  );
}