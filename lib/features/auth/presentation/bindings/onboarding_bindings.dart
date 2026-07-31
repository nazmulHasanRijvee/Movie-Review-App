import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../../../../core/services/api_service.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingBindings extends Bindings{

  @override
  void dependencies() {

    Get.lazyPut<OnboardingController>(
        () => OnboardingController(apiService: Get.find<ApiService>()),
    );

  }

}