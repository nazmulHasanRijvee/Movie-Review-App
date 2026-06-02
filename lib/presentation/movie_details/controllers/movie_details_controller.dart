import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:of_28_movie_review_app/data/models/movie_details_model.dart';
import 'package:of_28_movie_review_app/data/repositories/movie_repository.dart';

import '../../../data/models/movie_result.dart';

class MovieDetailsController extends GetxController{


  final MovieRepository movieRepository;

  MovieDetailsController({ required this.movieRepository});

  MovieDetailsModel? _movieDetails;

  final RxBool isLoading = false.obs;

  String? _errorMessage;

  MovieDetailsModel? get movie => _movieDetails;
  String? get errorMessage => _errorMessage;

  Future<bool> fetchMovieDetails(int movieId) async {

    debugPrint('searching cache');
    final data = movieRepository.checkCache(movieId);
    if(data != null) {
      _movieDetails = data;
      return true;
    }



    bool isSuccess = false;
    isLoading.value = true;


    final MovieResult result = await movieRepository.getMovieDetails(movieId);


    if(result.isSuccess) {

      isSuccess = true;
      _errorMessage = null;

      _movieDetails = result.movieDetailsModel;

    } else {

      _errorMessage = result.errorMessage ?? 'Showing from controller';

    }

    isLoading.value = false;

    return isSuccess;

  }

}