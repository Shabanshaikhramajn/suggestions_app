import 'package:chat_app/core/network/api_client.dart';
import 'package:chat_app/data/datasource/assistant_remote_data_source.dart';
import 'package:chat_app/data/datasource/suggestions_remote_data_source.dart';
import 'package:chat_app/data/repository/assistant_repository_impl.dart';
import 'package:chat_app/data/repository/suggestions_repository_impl.dart';
import 'package:chat_app/domain/repository/assistant_repository.dart';
import 'package:chat_app/domain/repository/suggestions_repository.dart';
import 'package:chat_app/domain/usecases/suggestions_usecase.dart';
import 'package:chat_app/presentation/bloc/chat/chat_bloc.dart';
import 'package:chat_app/presentation/bloc/navigation/navigation_bloc.dart';
import 'package:chat_app/presentation/bloc/suggestions/suggestions_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {

  /// Blocs
  sl.registerFactory(
        () => NavigationBloc(),
  );

  sl.registerFactory(
        () => ChatBloc(),
  );

  sl.registerFactory(
        () => SuggestionBloc(
      sl(),
    ),
  );

  /// UseCases
  sl.registerLazySingleton(
        () => GetSuggestions(
      sl(),
    ),
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