import 'package:diary_mate/core/resources/data_state.dart';
import 'package:diary_mate/features/movie_recomendation/domain/entities/movie_recomendation_entity.dart';
import 'package:diary_mate/features/movie_recomendation/domain/usecases/get_recomendation.dart';

abstract class MovieRecomendationRepository {
  Future<DataState<List<MovieRecomendationEntity>>> getRecomendation(
    GetRecomendationParams params,
  );
}
