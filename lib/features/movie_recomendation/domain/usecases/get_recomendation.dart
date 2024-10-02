import 'package:diary_mate/core/resources/data_state.dart';
import 'package:diary_mate/core/usecases/usecase.dart';
import 'package:diary_mate/features/movie_recomendation/domain/entities/movie_recomendation_entity.dart';
import 'package:diary_mate/features/movie_recomendation/domain/repositories/movie_recomendation_repo.dart';

class GetRecomendationUsecase
    implements Usecase<DataState<List<MovieRecomendationEntity>>, GetRecomendationParams> {
  final MovieRecomendationRepository movieRecomendationRepository;

  GetRecomendationUsecase(this.movieRecomendationRepository);

  @override
  Future<DataState<List<MovieRecomendationEntity>>> execute({
    required GetRecomendationParams params,
  }) async {
    return movieRecomendationRepository.getRecomendation(params);
  }
}

class GetRecomendationParams {
  final String prompt;
  const GetRecomendationParams({required this.prompt});
}
