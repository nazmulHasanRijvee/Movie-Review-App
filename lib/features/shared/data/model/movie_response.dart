import 'movie_model.dart';

class MovieResponse {
  final List<MovieModel> results;

  MovieResponse({required this.results});

  factory MovieResponse.fromJson(Map<String, dynamic> json) {
    final data = json["results"]
        .map<MovieModel>((e) => MovieModel.fromJson(e))
        .toList();

    return MovieResponse(results: data);
  }
}
