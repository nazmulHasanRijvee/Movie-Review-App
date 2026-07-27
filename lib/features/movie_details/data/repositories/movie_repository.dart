import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:of_28_movie_review_app/features/movie_details/data/model/movie_details_model.dart';

import '../../../../core/services/api_service.dart';
import '../../../../core/utils/urls.dart';
import '../model/movie_result.dart';

class MovieRepository extends GetxService {

  final ApiService _apiService = Get.find<ApiService>();

  final LinkedHashMap<int, MovieDetailsModel> _cache = LinkedHashMap();


  MovieDetailsModel? checkCache(int movieId){

    debugPrint('getting from cache id: $movieId');

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

    final ApiResponse response = await _apiService.getRequest(url: Urls.getMovieById(movieId));

    if(response.isSuccess) {

      final movieDetails = MovieDetailsModel.fromJson(response.body);

      _cache[movieId] = movieDetails;

      debugPrint('Saving to cache: ${_cache[movieId]}');

      return MovieResult(
        movieDetailsModel: movieDetails,
        errorMessage: null,
      );

    }


    return MovieResult(
        movieDetailsModel: null,
        errorMessage: 'Status Code: ${response.statusCode} Message: ${response.errorMessage}'
    );

  }

}