import 'package:get/get.dart';

import '../../../../core/services/network/api_handler.dart';
import '../../../../core/services/network/rest_client.dart';
import '../../../shared/data/model/movie_model.dart';
import '../../../shared/data/model/movie_response.dart';

class SearchMovieController extends GetxController {
  RestClient get _restClient => Get.find<RestClient>();

  final RxBool isLoading = false.obs;

  String? _errorMessage;
  List<MovieModel> _searchResults = [];

  List<MovieModel> get searchResults => _searchResults;
  String? get errorMessage => _errorMessage;

  Future<bool> searchMovies(String query) async {
    bool isSuccess = false;
    isLoading.value = true;

    // final ApiResponse response = await _apiService.getRequest(
    //   url: Urls.searchMovieUrl(query),
    // );

    // if (response.isSuccess) {
    //   isSuccess = true;
    //   _errorMessage = null;

    //   _searchResults = response.body['results']
    //       .map<MovieModel>((e) => MovieModel.fromJson(e))
    //       .toList();
    // } else {
    //   _errorMessage =
    //       response.errorMessage ??
    //       "response.errorMessage is null from controller";
    //}

    await Api.call<MovieResponse>(
      action: _restClient.searchMovie(query),
      onSuccess: (data) {
        isSuccess = true;
        _errorMessage = null;

        _searchResults = data.results;
      },
      onError: (error) {
        isSuccess = false;
        _errorMessage = error;
      },
    );

    isLoading.value = false;

    return isSuccess;
  }
}
