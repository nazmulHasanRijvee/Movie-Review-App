
import 'package:get/get.dart';
import 'package:of_28_movie_review_app/features/movie_details/data/repositories/movie_repository.dart';

import '../../core/services/api_service.dart';


class AppBindings implements Bindings {

  @override
  void dependencies() {

    Get.put(ApiService(), permanent: true);

    Get.put(MovieRepository(), permanent: true);

  }

}