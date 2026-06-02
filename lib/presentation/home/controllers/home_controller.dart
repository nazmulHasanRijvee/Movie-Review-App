import 'package:get/get.dart';
import 'package:of_28_movie_review_app/data/models/movie_model.dart';
import 'package:of_28_movie_review_app/data/services/api_service.dart';

import '../../../data/utils/urls.dart';

class HomeController extends GetxController{

  final ApiService _apiService = Get.find<ApiService>();

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

  Future<bool> fetchMovies(String title) async {

    String url = '';

    switch(title.toLowerCase()){
      case 'trending':
        url = Urls.trendingUrl;
      case 'new':
        url = Urls.newlyReleased;
      case 'upcoming':
        url = Urls.upcomingMovies;
      default:
        url = Urls.trendingUrl;
    }

    bool isSuccess= false;
    if(_isLoading.value != true) _isLoading.value = true;

    final ApiResponse apiResponse = await _apiService.getRequest(url: url);

    if(apiResponse.isSuccess) {

      isSuccess = true;
      _errorMessage = null;

      final data = apiResponse.body['results'].map<MovieModel>(
              (e) => MovieModel.fromJson(e)
      ).toList();


      switch(title){
        case 'trending':
          _trendingMovies = data;
        case 'new':
          _newlyReleased = data;
        case 'upcoming':
          _upcoming = data;
        default:
          _trendingMovies = data;
      }

    } else {

      _errorMessage = apiResponse.errorMessage ?? 'Showing error from controller';

    }

    if(_trendingMovies.isNotEmpty && _newlyReleased.isNotEmpty && _upcoming.isNotEmpty) _isLoading.value = false;

    return isSuccess;

  }


}