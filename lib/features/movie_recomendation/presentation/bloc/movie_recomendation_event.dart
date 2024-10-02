part of 'movie_recomendation_bloc.dart';

abstract class MovieRecomendationEvent extends Equatable {
  const MovieRecomendationEvent();

  @override
  List<Object> get props => [];
}

final class GetMovieRecomendations extends MovieRecomendationEvent {
  final String prompt;
  const GetMovieRecomendations({required this.prompt});
}
