part of 'movie_recomendation_bloc.dart';

sealed class MovieRecomendationState extends Equatable {
  const MovieRecomendationState();

  @override
  List<Object> get props => [];
}

final class MovieRecomendationInitial extends MovieRecomendationState {}

final class MovieRecomendationLoading extends MovieRecomendationState {}

final class MovieRecomendationError extends MovieRecomendationState {
  final String error;
  const MovieRecomendationError(this.error);
}

final class MovieRecomendationLoaded extends MovieRecomendationState {
  final List<MovieRecomendationEntity> movieRecomendations;
  const MovieRecomendationLoaded(this.movieRecomendations);
}
