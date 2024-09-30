part of 'diary_bloc.dart';

abstract class DiaryState extends Equatable {
  final List<DiaryEntity>? diaryEntries;

  const DiaryState({this.diaryEntries});

  @override
  List<Object> get props => [diaryEntries!];
}

final class DiaryInitial extends DiaryState {}

final class DiaryLoading extends DiaryState {
  const DiaryLoading();
}

final class DiaryLoaded extends DiaryState {
  const DiaryLoaded(List<DiaryEntity> diaryEntries)
      : super(diaryEntries: diaryEntries);
}

final class DiaryError extends DiaryState {
  final String error;
  const DiaryError(this.error);
}
