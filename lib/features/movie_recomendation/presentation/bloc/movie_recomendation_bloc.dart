import 'package:diary_mate/core/resources/data_state.dart';
import 'package:diary_mate/features/movie_recomendation/domain/entities/movie_recomendation_entity.dart';
import 'package:diary_mate/features/movie_recomendation/domain/usecases/get_recomendation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

part 'movie_recomendation_event.dart';
part 'movie_recomendation_state.dart';

class MovieRecomendationBloc
    extends Bloc<MovieRecomendationEvent, MovieRecomendationState> {
  final Logger _logger;
  final GetRecomendationUsecase _getRecomendationUsecase;

  MovieRecomendationBloc({
    required Logger logger,
    required GetRecomendationUsecase getMovieRecomendationsUsecase,
  })  : _logger = logger,
        _getRecomendationUsecase = getMovieRecomendationsUsecase,
        super(MovieRecomendationInitial()) {
    on<GetMovieRecomendations>(_onGetMovieRecomendations);
  }

  _onGetMovieRecomendations(
    GetMovieRecomendations event,
    Emitter<MovieRecomendationState> emit,
  ) async {
    try {
      emit(MovieRecomendationLoading());
      final recomendations = await _getRecomendationUsecase.execute(
        params: GetRecomendationParams(prompt: event.prompt),
      );

      if (recomendations is DataFailure) {
        _logger.e('Error fetching recomendations: ${recomendations.message}');
        emit(MovieRecomendationError(recomendations.message!));
      }

      final movieRecomendations =
          recomendations.data as List<MovieRecomendationEntity>;
      emit(MovieRecomendationLoaded(movieRecomendations));
    } catch (e) {
      _logger.e('Error fetching movie recomendations: $e');
      emit(const MovieRecomendationError(
        'Failed to fetch movie recomendations',
      ));
    }
  }
}
