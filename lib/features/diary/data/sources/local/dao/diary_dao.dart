
import 'package:diary_mate/common/constants/app_constants.dart';
import 'package:diary_mate/features/diary/data/models/diary_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class DiaryDao {
  // insert / update
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertDiaryEntry(DiaryModel diaryModel);

  // delete
  @delete
  Future<void> deleteDiaryEntry(DiaryModel diaryModel);

  // select
  @Query('SELECT * FROM $diaryTableName')
  Future<List<DiaryModel>> selectAll();

  @Query('SELECT * FROM $diaryTableName WHERE id = :id')
  Future<DiaryModel?> selectById(String id);

}
