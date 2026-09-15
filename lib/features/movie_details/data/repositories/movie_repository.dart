import 'dart:collection';

import 'package:get/get.dart';
import 'package:of_28_movie_review_app/features/movie_details/data/model/movie_details_model.dart';

import '../../../../core/logger/app_logger.dart';
import '../../../../core/services/network/api_handler.dart';
import '../../../../core/services/network/rest_client.dart';
import '../model/movie_result.dart';

class MovieRepository extends GetxService {
  // DI
  RestClient get _restClient => Get.find<RestClient>();

  final LinkedHashMap<int, MovieDetailsModel> _cache = LinkedHashMap();

  MovieDetailsModel? checkCache(int movieId) {
    AppLogger.info('getting from cache, id: $movieId');

    if (!_cache.containsKey(movieId)) {
      return null;
    }

    final movie = _cache.remove(movieId)!;
    _cache[movieId] = movie;

    return movie;
  }

  void saveMovie(int movieId, MovieDetailsModel movie) {
    _cache.remove(movieId); // to check if the movie is present the remove it

    if (_cache.length >= 3) {
      _cache.remove(_cache.keys.first);
    }
    _cache[movieId] = movie;
  }

  Future<MovieResult> getMovieDetails(int movieId) async {
    MovieResult? movieResult;

    await Api.call<MovieDetailsModel>(
      action: _restClient.movieById(movieId),
      onSuccess: (movieDetails) {
        _cache[movieId] = movieDetails;
        AppLogger.info('Saving to cache: ${_cache[movieId]}');
        movieResult = MovieResult(
          movieDetailsModel: movieDetails,
          errorMessage: null,
        );
      },
      onError: (error) {
        AppLogger.error('Error fetching movie details: $error');
        movieResult = MovieResult(movieDetailsModel: null, errorMessage: error);
      },
    );

    return movieResult ??
        MovieResult(
          movieDetailsModel: null,
          errorMessage:
              'Failed to fetch movie details throwing from repository',
        );
  }
}
