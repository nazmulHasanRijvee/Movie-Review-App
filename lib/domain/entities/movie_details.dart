class MovieDetails {
  final int id;
  final String title;
  final String overview;
  final String tagLine;
  final String? posterPath;
  final String? backdropPath;
  final double voteAverage;
  final double voteCount;
  final String releaseDate;
  final int duration;
  final List<dynamic> genres;

  MovieDetails({
    required this.id,
    required this.title,
    required this.overview,
    required this.tagLine,
    required this.posterPath,
    required this.backdropPath,
    required this.voteAverage,
    required this.voteCount,
    required this.releaseDate,
    required this.duration,
    required this.genres,
  });
}