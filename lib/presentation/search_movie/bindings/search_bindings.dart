import 'package:get/get.dart';
import 'package:of_28_movie_review_app/presentation/search_movie/controllers/search_movie_controller.dart';

class SearchBindings implements Bindings{

  @override
  void dependencies() {

    Get.lazyPut(() => SearchMovieController());

  }

}