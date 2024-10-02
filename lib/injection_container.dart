import 'package:diary_mate/common/widgets/bottom_app_bar/bloc/navigation_bloc.dart';
import 'package:diary_mate/features/diary/data/implementaions/diary_repository_impl.dart';
import 'package:diary_mate/features/diary/data/sources/local/app_database.dart';
import 'package:diary_mate/features/diary/domain/repositories/diary_repository.dart';
import 'package:diary_mate/features/diary/domain/usecases/get_all_entries_usecase.dart';
import 'package:diary_mate/features/diary/domain/usecases/remove_diary_entry.dart';
import 'package:diary_mate/features/diary/domain/usecases/save_diary_entry.dart';
import 'package:diary_mate/features/diary/presentation/bloc/diary_bloc.dart';
import 'package:diary_mate/features/movie_recomendation/data/implementaions/movie_recomendation_impl.dart';
import 'package:diary_mate/features/movie_recomendation/data/sources/movie_recomendation_sources.dart';
import 'package:diary_mate/features/movie_recomendation/domain/repositories/movie_recomendation_repo.dart';
import 'package:diary_mate/features/movie_recomendation/domain/usecases/get_recomendation.dart';
import 'package:diary_mate/features/movie_recomendation/presentation/bloc/movie_recomendation_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> registerDependencies() async {
  other();
  core();
  dataSources();
  repositories();
  useCases();
  blocs();
}

void other() async {
  //* Register SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  //* Register FlutterSecureStorage
  const secureStorage = FlutterSecureStorage();
  sl.registerSingleton<FlutterSecureStorage>(secureStorage);

  //* Register Logger
  sl.registerSingleton<Logger>(Logger());
}

void core() async {
  //* Register NavigationBloc
  sl.registerLazySingleton<NavigationBloc>(
    () => NavigationBloc(),
  );
}

void dataSources() async {
  // DiaryDatabase
  final appDatabase = await $FloorAppDatabase.databaseBuilder('diary_mate.db').build();
  sl.registerSingleton<AppDatabase>(appDatabase);

  // MovieRecomendationSources
  sl.registerLazySingleton<MovieRecomendationSources>(
    () => MovieRecomendationSources(
      sl<Logger>(),
    ),
  );
}

void repositories() async {
  // DiaryRepository
  sl.registerLazySingleton<DiaryRepository>( 
    () => DiaryRepositoryImpl(
      sl<AppDatabase>(),
      sl<Logger>(),
    ),
  );

  // Movie Recommendation Repository
  sl.registerLazySingleton<MovieRecomendationRepository>(
    () => MovieRecomendationRepositoryImpl(
      logger: sl<Logger>(),
      sources: sl<MovieRecomendationSources>(),
    ),
  );
}

void useCases() async {
  // GetAllEntriesUsecase
  sl.registerLazySingleton<GetAllEntriesUsecase>(
    () => GetAllEntriesUsecase(
      sl<DiaryRepository>(),
    ),
  );

  // SaveDiaryEntry
  sl.registerLazySingleton<SaveDiaryEntry>(
    () => SaveDiaryEntry(
      sl<DiaryRepository>(),
    ),
  );

  // RemoveDiaryEntry
  sl.registerLazySingleton<RemoveDiaryEntry>(
    () => RemoveDiaryEntry(
      sl<DiaryRepository>(),
    ),
  );

  // Get Movie Recommendation Usecase
  sl.registerLazySingleton<GetRecomendationUsecase>(
    () => GetRecomendationUsecase(
      sl<MovieRecomendationRepository>(),
    ),
  );
}

void blocs() async {
  // DiaryBloc
  sl.registerLazySingleton<DiaryBloc>(
    () => DiaryBloc(
      logger: sl<Logger>(),
      saveDiaryEntry: sl<SaveDiaryEntry>(),
      getAllEntriesUsecase: sl<GetAllEntriesUsecase>(),
      removeDiaryEntry: sl<RemoveDiaryEntry>(),
    ),
  );
  // MovieRecomendationBloc
  sl.registerLazySingleton<MovieRecomendationBloc>(
    () => MovieRecomendationBloc(
      logger: sl<Logger>(),
      getMovieRecomendationsUsecase: sl<GetRecomendationUsecase>(),
    ),
  );
}