import 'package:get/get.dart';
import 'package:of_28_movie_review_app/data/services/api_service.dart';

class AppBindings implements Bindings {

  @override
  void dependencies() {

    Get.put(ApiService(), permanent: true);

  }

}