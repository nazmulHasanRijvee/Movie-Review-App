import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:of_28_movie_review_app/data/models/movie_details_model.dart';
import 'package:of_28_movie_review_app/data/services/api_service.dart';

import '../models/movie_result.dart';
import '../utils/urls.dart';

class MovieRepository extends GetxService {

  final ApiService _apiService = Get.find<ApiService>();

  final Map<int, MovieDetailsModel> _cache = {};


  MovieDetailsModel? checkCache(int movieId){

    debugPrint('getting from cache id: $movieId');

    if(_cache.containsKey(movieId)) {
      return _cache[movieId];
    }

    return null;

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