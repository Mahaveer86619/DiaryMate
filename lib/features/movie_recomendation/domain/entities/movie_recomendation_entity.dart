class MovieRecomendationEntity {
  final String movieName;
  final String movieRating;
  final String abstract;

  const MovieRecomendationEntity({
    required this.movieName,
    required this.movieRating,
    required this.abstract,
  });

  MovieRecomendationEntity copyWith({
    String? movieName,
    String? movieRating,
    String? abstract,
  }) {
    return MovieRecomendationEntity(
      movieName: movieName ?? this.movieName,
      movieRating: movieRating ?? this.movieRating,
      abstract: abstract ?? this.abstract,
    );
  }

  @override
  String toString() {
    return '''MovieRecomendationEntity{
    movieName: $movieName, 
    movieRating: $movieRating, 
    abstract: $abstract
    }''';
  }
}
