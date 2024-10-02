import 'package:diary_mate/features/movie_recomendation/domain/entities/movie_recomendation_entity.dart';

class MovieRecomendationModel extends MovieRecomendationEntity {
  MovieRecomendationModel({
    required super.movieName,
    required super.movieRating,
    required super.abstract,
  });

  factory MovieRecomendationModel.fromJson(Map<String, dynamic> json) {
    return MovieRecomendationModel(
      movieName: json['name'] as String,
      movieRating: json['rating'] as String,
      abstract: json['abstract'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': movieName,
      'rating': movieRating,
      'abstract': abstract,
    };
  }

  // to entity
  factory MovieRecomendationModel.fromEntity(MovieRecomendationEntity entity) {
    return MovieRecomendationModel(
      movieName: entity.movieName,
      movieRating: entity.movieRating,
      abstract: entity.abstract,
    );
  }

  MovieRecomendationEntity toEntity() {
    return MovieRecomendationEntity(
      movieName: movieName,
      movieRating: movieRating,
      abstract: abstract,
    );
  }
}
