import 'package:diary_mate/common/widgets/bottom_app_bar/bloc/navigation_bloc.dart';
import 'package:diary_mate/features/diary/data/implementaions/diary_repository_impl.dart';
import 'package:diary_mate/features/diary/data/sources/local/app_database.dart';
import 'package:diary_mate/features/diary/domain/repositories/diary_repository.dart';
import 'package:diary_mate/features/diary/domain/usecases/get_all_entries_usecase.dart';
import 'package:diary_mate/features/diary/domain/usecases/remove_diary_entry.dart';
import 'package:diary_mate/features/diary/domain/usecases/save_diary_entry.dart';
import 'package:diary_mate/features/diary/presentation/bloc/diary_bloc.dart';
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
}

void repositories() async {
  // DiaryRepository
  sl.registerLazySingleton<DiaryRepository>( 
    () => DiaryRepositoryImpl(
      sl<AppDatabase>(),
      sl<Logger>(),
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
}