import 'package:get/get.dart';
import 'package:of_28_movie_review_app/data/services/api_service.dart';
import 'package:of_28_movie_review_app/data/utils/urls.dart';

class MovieDetailsController extends GetxController{

  final ApiService _apiService = Get.find<ApiService>();

  final RxBool isLoading = false.obs;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<Map<String, dynamic>?> fetchMovieDetails(int movieId) async {

    isLoading.value = true;
    Map<String, dynamic>? details;

    final ApiResponse response = await _apiService.getRequest(url: Urls.getMovieById(movieId));

    if(response.isSuccess) {

      _errorMessage = null;

      details = response.body;

    } else {

      _errorMessage = response.errorMessage ?? "Showing error from controller";

    }

    isLoading.value = false;

    return details;

  }

}