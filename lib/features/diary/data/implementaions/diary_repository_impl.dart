import 'package:diary_mate/features/diary/data/models/diary_model.dart';
import 'package:diary_mate/features/diary/data/sources/local/app_database.dart';
import 'package:diary_mate/features/diary/domain/entities/diary_entity.dart';
import 'package:diary_mate/features/diary/domain/repositories/diary_repository.dart';
import 'package:logger/logger.dart';

class DiaryRepositoryImpl implements DiaryRepository {
  final AppDatabase _appDatabase;
  final Logger _logger;

  DiaryRepositoryImpl(this._appDatabase, this._logger);

  @override
  Future<void> insertDiaryEntry(DiaryEntity diaryEntity) async {
    _logger.i('Inserting new diary entry...');
    return await _appDatabase.diaryDao
        .insertDiaryEntry(DiaryModel.fromEntity(diaryEntity));
  }

  @override
  Future<List<DiaryModel>> selectAll() async {
    _logger.i('Selecting all diary entries...');
    return await _appDatabase.diaryDao.selectAll();
  }

  @override
  Future<DiaryModel?> selectById(String id) async {
    _logger.i('Selecting diary entry by id...');
    return await _appDatabase.diaryDao.selectById(id);
  }

  @override
  Future<void> deleteDiaryEntry(DiaryEntity diaryEntity) async {
    _logger.i('Deleting diary entry...');
    return await _appDatabase.diaryDao
        .deleteDiaryEntry(DiaryModel.fromEntity(diaryEntity));
  }
}
