import 'dart:async';

import 'package:diary_mate/features/diary/data/models/diary_model.dart';
import 'package:diary_mate/features/diary/data/sources/local/dao/diary_dao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [DiaryModel])
abstract class AppDatabase extends FloorDatabase {
  DiaryDao get diaryDao;
}