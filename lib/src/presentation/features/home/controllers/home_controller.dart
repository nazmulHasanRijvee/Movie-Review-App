import 'package:get/get.dart';
import 'package:of_28_movie_review_app/src/data/services/auth_controller.dart';
import 'package:of_28_movie_review_app/src/data/services/network/rest_client.dart';
import 'package:of_28_movie_review_app/src/data/models/movie_model.dart';
import 'package:of_28_movie_review_app/src/data/services/api_service.dart';
import 'package:of_28_movie_review_app/src/core/utils/urls.dart';
import 'package:of_28_movie_review_app/src/data/models/movie_response.dart';

import '../../../../data/services/network/api_handler.dart';

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
