import 'package:diary_mate/core/usecases/usecase.dart';
import 'package:diary_mate/features/diary/domain/entities/diary_entity.dart';
import 'package:diary_mate/features/diary/domain/repositories/diary_repository.dart';

class RemoveDiaryEntry implements Usecase<void, DiaryEntity> {
  final DiaryRepository _diaryRepository;

  RemoveDiaryEntry(this._diaryRepository);

  @override
  Future<void> execute({required DiaryEntity params}) {
    return _diaryRepository.deleteDiaryEntry(params);
  }
}