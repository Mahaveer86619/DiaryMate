import 'dart:convert';
import 'dart:developer';

class GeminiAIResponse {
  final List<Candidate> candidates;
  final UsageMetadata usageMetadata;

  GeminiAIResponse({required this.candidates, required this.usageMetadata});

  factory GeminiAIResponse.fromJson(String data) {
    print("Sring data:");
    log(data);
    final Map<String, dynamic> json = jsonDecode(data);
    // print("Map data:");
    // logger.i(json);
    return GeminiAIResponse(
      candidates: List<Candidate>.from(
          json['candidates'].map((x) => Candidate.fromJson(x))),
      usageMetadata: UsageMetadata.fromJson(json['usageMetadata']),
    );
  }
}

class Candidate {
  final Content content;
  final String finishReason;
  final int index;
  final List<SafetyRating> safetyRatings;

  Candidate({
    required this.content,
    required this.finishReason,
    required this.index,
    required this.safetyRatings,
  });

  factory Candidate.fromJson(Map<String, dynamic> json) {
    return Candidate(
      content: Content.fromJson(json['content']),
      finishReason: json['finishReason'],
      index: json['index'],
      safetyRatings: List<SafetyRating>.from(
          json['safetyRatings'].map((x) => SafetyRating.fromJson(x))),
    );
  }
}

class Content {
  final List<Part> parts;
  final String role;

  Content({required this.parts, required this.role});

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      parts: List<Part>.from(json['parts'].map((x) => Part.fromJson(x))),
      role: json['role'],
    );
  }
}

class Part {
  final String text;

  Part({required this.text});

  factory Part.fromJson(Map<String, dynamic> json) {
    return Part(
      text: json['text'],
    );
  }
}

class SafetyRating {
  final String category;
  final String probability;

  SafetyRating({required this.category, required this.probability});

  factory SafetyRating.fromJson(Map<String, dynamic> json) {
    return SafetyRating(
      category: json['category'],
      probability: json['probability'],
    );
  }
}

class UsageMetadata {
  final int promptTokenCount;
  final int candidatesTokenCount;
  final int totalTokenCount;

  UsageMetadata(
      {required this.promptTokenCount,
      required this.candidatesTokenCount,
      required this.totalTokenCount});

  factory UsageMetadata.fromJson(Map<String, dynamic> json) {
    return UsageMetadata(
      promptTokenCount: json['promptTokenCount'],
      candidatesTokenCount: json['candidatesTokenCount'],
      totalTokenCount: json['totalTokenCount'],
    );
  }
}
