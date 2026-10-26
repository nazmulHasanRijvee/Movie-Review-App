import 'package:get/get.dart';
import 'package:cinephiler/src/data/models/movie_details_model.dart';
import 'package:cinephiler/src/data/repositories/movie_repository_impl.dart';

import '../../../../core/logger/app_logger.dart';
import '../../../../data/models/movie_result.dart';

class MovieDetailsController extends GetxController {
  final MovieRepositoryImpl movieRepository;

  MovieDetailsController({required this.movieRepository});

  MovieDetailsModel? _movieDetails;

  final RxBool _isLoading = false.obs;

  String? _errorMessage;

  MovieDetailsModel? get movie => _movieDetails;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading.value;

  Future<bool> fetchMovieDetails(int movieId) async {
    AppLogger.info("Searching Cache");
    final data = movieRepository.checkCache(movieId);
    if (data != null) {
      _movieDetails = data;
      return true;
    }

    bool isSuccess = false;
    _isLoading.value = true;

    final MovieResult result = await movieRepository.getMovieDetails(movieId);

    if (result.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
      _movieDetails = result.movieDetailsModel;
    } else {
      _errorMessage = result.errorMessage ?? 'Showing from controller';
    }

    _isLoading.value = false;

    return isSuccess;
  }
}
