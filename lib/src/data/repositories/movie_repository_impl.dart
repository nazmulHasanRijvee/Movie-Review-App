import 'dart:collection';

import 'package:get/get.dart';
import 'package:cinephiler/src/data/models/movie_details_model.dart';
import 'package:cinephiler/src/domain/repositories/movie_repository.dart';

import '../../core/logger/app_logger.dart';
import '../services/network/api_handler.dart';
import '../services/network/rest_client.dart';
import '../models/movie_result.dart';

class MovieRepositoryImpl extends GetxService implements MovieRepository {
  // DI
  RestClient get _restClient => Get.find<RestClient>();

  final LinkedHashMap<int, MovieDetailsModel> _cache = LinkedHashMap();

  @override
  MovieDetailsModel? checkCache(int movieId) {
    AppLogger.info('getting from cache, id: $movieId');

    if (!_cache.containsKey(movieId)) {
      return null;
    }

    final movie = _cache.remove(movieId)!;
    _cache[movieId] = movie;

    return movie;
  }

  @override
  void saveMovie(int movieId, MovieDetailsModel movie) {
    _cache.remove(movieId); // to check if the movie is present the remove it

    if (_cache.length >= 3) {
      _cache.remove(_cache.keys.first);
    }

    _cache[movieId] = movie;
  }

  @override
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
