import 'package:diary_mate/common/widgets/dashboard.dart';
import 'package:diary_mate/common/widgets/splash_screen.dart';
import 'package:diary_mate/features/diary/presentation/screens/add_diary_entry_screen.dart';
import 'package:diary_mate/features/diary/presentation/screens/diary_screen.dart';
import 'package:flutter/material.dart';

final routes = <String, WidgetBuilder>{
  '/': (context) => const SplashScreen(),

  // Main Routes
  '/dashboard': (context) => const Dashboard(),
  '/diary': (context) => const DiaryScreen(),
  '/add_diary_entry': (context) => const AddDiaryEntryScreen(),
};
