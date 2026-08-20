import 'package:get/get.dart';

import '../controllers/search_movie_controller.dart';

class SearchBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchMovieController());
  }
}
