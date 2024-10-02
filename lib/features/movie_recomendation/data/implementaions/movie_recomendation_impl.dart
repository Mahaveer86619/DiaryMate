import 'package:diary_mate/core/resources/data_state.dart';
import 'package:diary_mate/features/movie_recomendation/data/models/movie_recomendation_model.dart';
import 'package:diary_mate/features/movie_recomendation/data/sources/movie_recomendation_sources.dart';
import 'package:diary_mate/features/movie_recomendation/domain/entities/movie_recomendation_entity.dart';
import 'package:diary_mate/features/movie_recomendation/domain/repositories/movie_recomendation_repo.dart';
import 'package:diary_mate/features/movie_recomendation/domain/usecases/get_recomendation.dart';
import 'package:logger/logger.dart';

class MovieRecomendationRepositoryImpl implements MovieRecomendationRepository {
  final Logger logger;
  final MovieRecomendationSources sources;

  MovieRecomendationRepositoryImpl({
    required this.sources,
    required this.logger,
  });

  @override
  Future<DataState<List<MovieRecomendationEntity>>> getRecomendation(
    GetRecomendationParams params,
  ) async {
    final response = await sources.getRecomendation(params);

    if (response is DataFailure) {
      logger.e("Error fetching user events: ${response.message}");
      return DataFailure("Something went wrong", -1);
    }

    final jsonData = response.data!;

    final jsonTestList = jsonData
        .map((model) => MovieRecomendationModel.fromJson(model))
        .toList();

    return DataSuccess(jsonTestList, 'Success');

    // return jsonData.map((e) => MovieRecomendationEntity.fromJson(e)).toList();
  }
}
