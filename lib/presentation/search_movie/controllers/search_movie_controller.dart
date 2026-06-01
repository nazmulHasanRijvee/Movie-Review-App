import 'package:get/get.dart';
import 'package:of_28_movie_review_app/data/models/movie_model.dart';
import 'package:of_28_movie_review_app/data/services/api_service.dart';

import '../../../data/utils/urls.dart';

class SearchMovieController extends GetxController{

  final ApiService _apiService = Get.find<ApiService>();

  final RxBool isLoading = false.obs;

  String? _errorMessage;
  List<MovieModel> _searchResults = [];


  List<MovieModel> get searchResults => _searchResults;
  String? get errorMessage => _errorMessage;

  Future<bool> searchMovies (String query) async {

    bool isSuccess = false;
    isLoading.value = true;

    final ApiResponse response = await _apiService.getRequest(url: Urls.searchMovieUrl(query));

    if(response.isSuccess) {

      isSuccess = true;
      _errorMessage = null;

      _searchResults = response.body['results'].map<MovieModel>(
              (e) => MovieModel.fromJson(e)
      ).toList();

    } else {

      _errorMessage = response.errorMessage ?? "response.errorMessage is null from controller";

    }

    isLoading.value = false;

    return isSuccess;

  }


}