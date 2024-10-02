import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:diary_mate/core/resources/data_state.dart';
import 'package:diary_mate/features/movie_recomendation/domain/usecases/get_recomendation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class MovieRecomendationSources {
  final Logger logger;

  MovieRecomendationSources(this.logger);

  Future<DataState<List<Map<String, dynamic>>>> getRecomendation(
    GetRecomendationParams params,
  ) async {
    try {
      logger.i('Getting movie recommendations...');

      final apiKey = dotenv.get('GEMINI_API_KEY');
      final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: apiKey,
      );

      final res = await model.generateContent([Content.text(params.prompt)]);

      // Check for "json content" prefix and suffix
      String cleanedResponse = res.text!;
      if (cleanedResponse.startsWith("```json") &&
          cleanedResponse.endsWith("```")) {
        cleanedResponse =
            cleanedResponse.substring(8, cleanedResponse.length - 3);
      }

      final data = const JsonDecoder().convert(cleanedResponse);
      final movieList = data['movies'];

      if (movieList is List<dynamic>) {
        final movieListJson = movieList.map((e) {
          return e as Map<String, dynamic>;
        }).toList();

        return DataSuccess(
          movieListJson,
          'Extracted text from response',
        );
      }

      return DataFailure('Failed to parse response', -1);
    } catch (error) {
      if (error is SocketException || error is TimeoutException) {
        logger.e('Network error: $error');
        return DataFailure('Network error: $error', -1);
      } else {
        logger.e('Unknown error: $error');
        return DataFailure('Unknown error: $error', -1);
      }
    }
  }
}
