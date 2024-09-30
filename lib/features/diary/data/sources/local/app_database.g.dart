// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  DiaryDao? _diaryDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Diary` (`id` TEXT NOT NULL, `entryTitle` TEXT NOT NULL, `entryContent` TEXT NOT NULL, `date` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  DiaryDao get diaryDao {
    return _diaryDaoInstance ??= _$DiaryDao(database, changeListener);
  }
}

class _$DiaryDao extends DiaryDao {
  _$DiaryDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _diaryModelInsertionAdapter = InsertionAdapter(
            database,
            'Diary',
            (DiaryModel item) => <String, Object?>{
                  'id': item.id,
                  'entryTitle': item.entryTitle,
                  'entryContent': item.entryContent,
                  'date': item.date
                }),
        _diaryModelDeletionAdapter = DeletionAdapter(
            database,
            'Diary',
            ['id'],
            (DiaryModel item) => <String, Object?>{
                  'id': item.id,
                  'entryTitle': item.entryTitle,
                  'entryContent': item.entryContent,
                  'date': item.date
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<DiaryModel> _diaryModelInsertionAdapter;

  final DeletionAdapter<DiaryModel> _diaryModelDeletionAdapter;

  @override
  Future<List<DiaryModel>> selectAll() async {
    return _queryAdapter.queryList('SELECT * FROM Diary',
        mapper: (Map<String, Object?> row) => DiaryModel(
            id: row['id'] as String,
            entryTitle: row['entryTitle'] as String,
            entryContent: row['entryContent'] as String,
            date: row['date'] as String));
  }

  @override
  Future<DiaryModel?> selectById(String id) async {
    return _queryAdapter.query('SELECT * FROM Diary WHERE id = ?1',
        mapper: (Map<String, Object?> row) => DiaryModel(
            id: row['id'] as String,
            entryTitle: row['entryTitle'] as String,
            entryContent: row['entryContent'] as String,
            date: row['date'] as String),
        arguments: [id]);
  }

  @override
  Future<void> insertDiaryEntry(DiaryModel diaryModel) async {
    await _diaryModelInsertionAdapter.insert(
        diaryModel, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteDiaryEntry(DiaryModel diaryModel) async {
    await _diaryModelDeletionAdapter.delete(diaryModel);
  }
}
