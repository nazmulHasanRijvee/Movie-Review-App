import 'package:cinephiler/src/data/repositories/auth_repository_impl.dart';
import 'package:get/get.dart';
import 'package:cinephiler/src/data/services/network/rest_client.dart';
import 'package:cinephiler/src/presentation/core/routes/app_routes.dart';
import 'package:cinephiler/src/data/models/movie_model.dart';
import 'package:cinephiler/src/data/models/movie_response.dart';

import '../../../../data/services/network/api_handler.dart';

class HomeController extends GetxController {
  // DI
  AuthRepositoryImpl get _authRepo => Get.find<AuthRepositoryImpl>();
  RestClient get _restClient => Get.find<RestClient>();

  List<MovieModel> _trendingMovies = [];
  List<MovieModel> _newlyReleased = [];
  List<MovieModel> _upcoming = [];
  final RxBool _isLoading = false.obs;
  String? _errorMessage;

  List<MovieModel> get trendingMovies => _trendingMovies;
  List<MovieModel> get newlyReleased => _newlyReleased;
  List<MovieModel> get upcoming => _upcoming;
  bool get isLoading => _isLoading.value;
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

  Future<void> logOut() async {
    final isSuccess = await _authRepo.logOut();

    if (isSuccess) {
      Get.offAllNamed(AppRoutes.onboarding);
    }
  }
}
