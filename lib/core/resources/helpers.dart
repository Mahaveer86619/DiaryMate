import 'dart:math';

import 'package:diary_mate/common/constants/app_constants.dart';
import 'package:intl/intl.dart';

String formatString(String string, int maxLength) {
  if (string.length > maxLength) {
    return '${string.substring(0, maxLength)}...';
  }
  return string;
}

String formatDate(String iso8601String) {
  final DateTime dateTime = DateTime.parse(iso8601String);
  return DateFormat('d MMMM, yyyy').format(dateTime);
}

String formatTimeOfDay(String iso8601String) {
  final DateTime dateTime = DateTime.parse(iso8601String);
  return DateFormat('h:mm a').format(dateTime);
}

String getRandomString(List<String> strings) {
  final randomIndex = Random().nextInt(strings.length);
  return strings[randomIndex];
}

String getMovieRecomendationPrompt(String diaryEntryContent) {
  return movieRecomendationPrompt + diaryEntryContent;
}