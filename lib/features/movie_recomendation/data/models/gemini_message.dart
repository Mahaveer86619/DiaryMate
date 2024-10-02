import 'dart:convert';

class GeminiMessage {
  final List<GeminiContent> contents;

  GeminiMessage({required this.contents});

  factory GeminiMessage.fromJson(String data) {
    final Map<String, dynamic> json = jsonDecode(data);
    return GeminiMessage(
      contents: List<GeminiContent>.from(
          json['contents'].map((x) => GeminiContent.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['contents'] = contents.map((v) => v.toJson()).toList();
    return data;
  }
}

class GeminiContent {
  final List<GeminiPart> parts;

  GeminiContent({required this.parts});

  factory GeminiContent.fromJson(Map<String, dynamic> json) {
    return GeminiContent(
      parts: List<GeminiPart>.from(
          json['parts'].map((x) => GeminiPart.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['parts'] = parts.map((v) => v.toJson()).toList();
    return data;
  }
}

class GeminiPart {
  final String text;

  GeminiPart({required this.text});

  factory GeminiPart.fromJson(Map<String, dynamic> json) {
    return GeminiPart(
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['text'] = text;
    return data;
  }
}
