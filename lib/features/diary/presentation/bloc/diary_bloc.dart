import 'package:diary_mate/features/diary/domain/entities/diary_entity.dart';
import 'package:diary_mate/features/diary/domain/usecases/get_all_entries_usecase.dart';
import 'package:diary_mate/features/diary/domain/usecases/remove_diary_entry.dart';
import 'package:diary_mate/features/diary/domain/usecases/save_diary_entry.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

part 'diary_event.dart';
part 'diary_state.dart';

class DiaryBloc extends Bloc<DiaryEvent, DiaryState> {
  final Logger logger;

  final SaveDiaryEntry saveDiaryEntry;
  final GetAllEntriesUsecase getAllEntriesUsecase;
  final RemoveDiaryEntry removeDiaryEntry;

  DiaryBloc({
    required this.logger,
    required this.saveDiaryEntry,
    required this.getAllEntriesUsecase,
    required this.removeDiaryEntry,
  }) : super(DiaryInitial()) {
    on<DiarySaveEntry>(onSaveEntry);
    on<DiaryGetAllEntries>(onGetAllEntries);
    on<DiaryRemoveEntry>(onRemoveEntry);
  }

  void onSaveEntry(
    DiarySaveEntry event,
    Emitter<DiaryState> emit,
  ) async {
    try {
      emit(const DiaryLoading());
      await saveDiaryEntry.execute(params: event.diaryEntry!);
      final diaryEntries = await getAllEntriesUsecase.execute();
      emit(DiaryLoaded(diaryEntries));
    } catch (e) {
      logger.e(e);
      emit(const DiaryError('Something Went Wrong!'));
    }
  }

  void onGetAllEntries(
    DiaryGetAllEntries event,
    Emitter<DiaryState> emit,
  ) async {
    try {
      emit(const DiaryLoading());
      final diaryEntries = await getAllEntriesUsecase.execute();
      emit(DiaryLoaded(diaryEntries));
    } catch (e) {
      logger.e(e);
      emit(const DiaryError('Something Went Wrong!'));
    }
  }

  void onRemoveEntry(
    DiaryRemoveEntry event,
    Emitter<DiaryState> emit,
  ) async {
    try {
      emit(const DiaryLoading());
      await removeDiaryEntry.execute(params: event.diaryEntry!);
      final diaryEntries = await getAllEntriesUsecase.execute();
      emit(DiaryLoaded(diaryEntries));
    } catch (e) {
      logger.e(e);
      emit(const DiaryError('Something Went Wrong!'));
    }
  }
}
