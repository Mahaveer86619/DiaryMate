import 'package:diary_mate/core/usecases/usecase.dart';
import 'package:diary_mate/features/diary/domain/entities/diary_entity.dart';
import 'package:diary_mate/features/diary/domain/repositories/diary_repository.dart';

class SaveDiaryEntry implements Usecase<void, DiaryEntity> {
  final DiaryRepository _diaryRepository;

  SaveDiaryEntry(this._diaryRepository);

  @override
  Future<void> execute({required DiaryEntity params}) {
    return _diaryRepository.insertDiaryEntry(params);
  }
}
