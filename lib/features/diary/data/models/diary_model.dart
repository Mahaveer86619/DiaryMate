import 'package:diary_mate/common/constants/app_constants.dart';
import 'package:diary_mate/features/diary/domain/entities/diary_entity.dart';
import 'package:floor/floor.dart';

@Entity(tableName: diaryTableName, primaryKeys: ['id'])
class DiaryModel extends DiaryEntity {
  DiaryModel({
    required super.id,
    required super.entryTitle,
    required super.entryContent,
    required super.date,
  });

  factory DiaryModel.fromJson(Map<String, dynamic> json) {
    return DiaryModel(
      id: json['id'] as String,
      entryTitle: json['entryTitle'] as String,
      entryContent: json['entryContent'] as String,
      date: json['date'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'entryTitle': entryTitle,
      'entryContent': entryContent,
      'date': date,
    };
  }

  // a JSON convertor for AI generation
  Map<String, dynamic> toJsonForAI() {
    return {
      'entryTitle': entryTitle,
      'entryContent': entryContent,
    };
  }

  // from entity to model
  factory DiaryModel.fromEntity(DiaryEntity entity) {
    return DiaryModel(
      id: entity.id,
      entryTitle: entity.entryTitle,
      entryContent: entity.entryContent,
      date: entity.date,
    );
  }
}
