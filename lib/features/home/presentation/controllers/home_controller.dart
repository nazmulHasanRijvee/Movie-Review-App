import 'package:get/get.dart';
import 'package:of_28_movie_review_app/app/controllers/auth_controller.dart';
import 'package:of_28_movie_review_app/core/services/network/rest_client.dart';
import 'package:of_28_movie_review_app/features/shared/data/model/movie_model.dart';
import 'package:of_28_movie_review_app/core/services/api_service.dart';
import 'package:of_28_movie_review_app/core/utils/urls.dart';
import 'package:of_28_movie_review_app/features/shared/data/model/movie_response.dart';

import '../../../../core/services/network/api_handler.dart';

class HomeController extends GetxController {
  // DI
  ApiService get _apiService => Get.find<ApiService>();
  AuthController get _authController => Get.find<AuthController>();
  RestClient get _restClient => Get.find<RestClient>();

  List<MovieModel> _trendingMovies = [];
  List<MovieModel> _newlyReleased = [];
  List<MovieModel> _upcoming = [];
  final RxBool _isLoading = false.obs;
  String? _errorMessage;

  List<MovieModel> get trendingMovies => _trendingMovies;
  List<MovieModel> get newlyReleased => _newlyReleased;
  List<MovieModel> get upcoming => _upcoming;
  RxBool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Future<bool> fetchMovies(String title) async {
  //   String url = '';

  //   switch (title.toLowerCase()) {
  //     case 'trending':
  //       url = Urls.trendingUrl;
  //     case 'new':
  //       url = Urls.newlyReleased;
  //     case 'upcoming':
  //       url = Urls.upcomingMovies;
  //     default:
  //       url = Urls.trendingUrl;
  //   }

  //   bool isSuccess = false;
  //   if (_isLoading.value != true) _isLoading.value = true;

  //   final ApiResponse apiResponse = await _apiService.getRequest(url: url);

  //   if (apiResponse.isSuccess) {
  //     isSuccess = true;
  //     _errorMessage = null;

  //     final data = apiResponse.body['results']
  //         .map<MovieModel>((e) => MovieModel.fromJson(e))
  //         .toList();

  //     switch (title) {
  //       case 'trending':
  //         _trendingMovies = data;
  //       case 'new':
  //         _newlyReleased = data;
  //       case 'upcoming':
  //         _upcoming = data;
  //       default:
  //         _trendingMovies = data;
  //     }
  //   } else {
  //     _errorMessage =
  //         apiResponse.errorMessage ?? 'Showing error from controller';
  //   }

  //   if (_trendingMovies.isNotEmpty &&
  //       _newlyReleased.isNotEmpty &&
  //       _upcoming.isNotEmpty) {
  //     _isLoading.value = false;
  //   }

  //   return isSuccess;
  // }

  Future<bool> fetchMovies() async {
    bool isSuccess = false;
    _isLoading.value = true;

    final results = await Future.wait([
      fetchNewReleases(),
      fetchUpcoming(),
      fetchTrending(),
    ]);

    if (!results.contains(false)) {
      isSuccess = true;
    }

    _isLoading.value = false;

    return isSuccess;
  }

  Future<bool> fetchTrending() async {
    bool isSuccess = false;

    await Api.call<MovieResponse>(
      action: _restClient.trending(),
      onSuccess: (response) {
        isSuccess = true;
        _errorMessage = null;
        _trendingMovies = response.results;
      },
      onError: (errorMessage) {
        _errorMessage = errorMessage;
      },
    );

    return isSuccess;
  }

  Future<bool> fetchNewReleases() async {
    bool isSuccess = false;

    await Api.call<MovieResponse>(
      action: _restClient.newlyReleased(),
      onSuccess: (response) {
        isSuccess = true;
        _errorMessage = null;
        _newlyReleased = response.results;
      },
      onError: (errorMessage) {
        _errorMessage = errorMessage;
      },
    );

    return isSuccess;
  }

  Future<bool> fetchUpcoming() async {
    bool isSuccess = false;

    await Api.call<MovieResponse>(
      action: _restClient.upcoming(),
      onSuccess: (response) {
        isSuccess = true;
        _errorMessage = null;
        _upcoming = response.results;
      },
      onError: (errorMessage) {
        _errorMessage = errorMessage;
      },
    );

    return isSuccess;
  }

  Future<bool> logOut() async {
    bool isSuccess = false;

    final sessionId = _authController.accessSessionId;

    if (sessionId == null) return false;

    final ApiResponse apiResponse = await _apiService.deleteRequest(
      url: Urls.deleteSessionId,
      body: {'session_id': sessionId},
    );

    if (apiResponse.isSuccess) {
      isSuccess = true;
      await _authController.clearUserData();
    } else {
      _errorMessage =
          apiResponse.errorMessage ?? 'Showing error from controller';
    }

    return isSuccess;
  }
}
