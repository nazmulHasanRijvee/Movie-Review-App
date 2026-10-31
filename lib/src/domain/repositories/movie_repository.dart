import '../../data/models/movie_details_model.dart';
import '../../data/models/movie_result.dart';

abstract interface class MovieRepository {
  MovieDetailsModel? checkCache(int movieId);

  void saveMovie(int movieId, MovieDetailsModel movie);

  Future<MovieResult> getMovieDetails(int movieId);
}
