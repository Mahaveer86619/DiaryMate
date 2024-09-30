part of 'diary_bloc.dart';

abstract class DiaryEvent extends Equatable {
  final DiaryEntity? diaryEntry;

  const DiaryEvent({this.diaryEntry});

  @override
  List<Object> get props => [diaryEntry!];
}

class DiarySaveEntry extends DiaryEvent {
  const DiarySaveEntry(DiaryEntity diaryEntity)
      : super(diaryEntry: diaryEntity);
}

class DiaryGetAllEntries extends DiaryEvent {
  const DiaryGetAllEntries();
}

class DiaryRemoveEntry extends DiaryEvent {
  const DiaryRemoveEntry(DiaryEntity diaryEntity)
      : super(diaryEntry: diaryEntity);
}
