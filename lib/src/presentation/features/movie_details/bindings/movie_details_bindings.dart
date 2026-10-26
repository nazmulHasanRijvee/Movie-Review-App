import 'package:get/get.dart';
import 'package:cinephiler/src/data/repositories/movie_repository_impl.dart';

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
