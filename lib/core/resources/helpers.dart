import 'dart:math';

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

String getRandomString(List<String> strings) {
  final randomIndex = Random().nextInt(strings.length);
  return strings[randomIndex];
}
