import 'package:get/get.dart';
import 'package:of_28_movie_review_app/presentation/home/controllers/home_controller.dart';

class HomeBindings implements Bindings {

  @override
  void dependencies() {

    Get.lazyPut(()=> HomeController());

  }

}