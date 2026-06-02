import 'package:of_28_movie_review_app/domain/entities/movie_details.dart';

class MovieDetailsModel extends MovieDetails {

  MovieDetailsModel({
    required super.id,
    required super.title,
    required super.overview,
    required super.tagLine,
    required super.posterPath,
    required super.backdropPath,
    required super.voteAverage,
    required super.voteCount,
    required super.releaseDate,
    required super.duration,
    required super.genres,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      id: json['id'],
      title: json['title'] ?? json['name'] ?? 'Unknown Title',
      overview: json['overview'] ?? '',
      tagLine: json['tagline'] ?? '',
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: (json['vote_count'] as num).toDouble(),
      releaseDate: json['release_date'] ?? json['first_air_date'] ?? '',
      duration: json['runtime'],
      genres: List.from(json['genres']),
    );
  }
}