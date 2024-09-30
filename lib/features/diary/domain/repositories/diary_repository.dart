import 'package:diary_mate/features/diary/domain/entities/diary_entity.dart';

abstract class DiaryRepository {
  Future<void> insertDiaryEntry(DiaryEntity diaryEntity);
  Future<void> deleteDiaryEntry(DiaryEntity diaryEntity);
  Future<List<DiaryEntity>> selectAll();
  Future<DiaryEntity?> selectById(String id);
}
