import 'package:get/get.dart';
import 'package:of_28_movie_review_app/src/data/repsoitories/movie_repository_impl.dart';

import '../controllers/movie_details_controller.dart';

class MovieDetailsBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() {
      final movieRepo = Get.find<MovieRepositoryImpl>();
      return MovieDetailsController(movieRepository: movieRepo);
    });
  }
}
