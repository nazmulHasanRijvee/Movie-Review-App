import 'package:get/get.dart';
import 'package:of_28_movie_review_app/features/movie_details/data/repositories/movie_repository.dart';

import '../controllers/movie_details_controller.dart';

class MovieDetailsBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() {
      final movieRepo = Get.find<MovieRepository>();
      return MovieDetailsController(movieRepository: movieRepo);
    });
  }
}
