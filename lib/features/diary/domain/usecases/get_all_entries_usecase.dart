import 'package:diary_mate/core/usecases/usecase.dart';
import 'package:diary_mate/features/diary/domain/entities/diary_entity.dart';
import 'package:diary_mate/features/diary/domain/repositories/diary_repository.dart';

class GetAllEntriesUsecase implements Usecase<List<DiaryEntity>, void> {
  final DiaryRepository _diaryRepository;

  GetAllEntriesUsecase(this._diaryRepository);

  @override
  Future<List<DiaryEntity>> execute({void params}) {
    return _diaryRepository.selectAll();
  }
}
