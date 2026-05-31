import 'package:get/get.dart';
import 'package:of_28_movie_review_app/data/models/movie_model.dart';
import 'package:of_28_movie_review_app/data/services/api_service.dart';

import '../../../data/utils/urls.dart';

class HomeController extends GetxController{

  final ApiService _apiService = Get.find<ApiService>();

  List<MovieModel> _trendingMovies = [];
  final RxBool _isLoading = false.obs;
  String? _errorMessage;

  List<MovieModel> get trendingMovies => _trendingMovies;
  RxBool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> fetchTrendingMovies() async {

    bool isSuccess= false;
    _isLoading.value = true;

    final ApiResponse apiResponse = await _apiService.getRequest(url: Urls.trendingUrl);

    if(apiResponse.isSuccess) {

      isSuccess = true;
      _errorMessage = null;

      _trendingMovies = apiResponse.body['results'].map<MovieModel>(
              (e) => MovieModel.fromJson(e)
      ).toList();

    } else {

      _errorMessage = apiResponse.errorMessage ?? 'Showing error from controller';

    }

    _isLoading.value = false;

    return isSuccess;

  }


}