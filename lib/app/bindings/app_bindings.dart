import 'package:get/get.dart';
import 'package:of_28_movie_review_app/app/controllers/auth_controller.dart';
import 'package:of_28_movie_review_app/features/movie_details/data/repositories/movie_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/app_strings.dart';
import '../../core/services/api_service.dart';
import '../routes/app_routes.dart';

class AppBindings implements Bindings {
  @override
  Future<void> dependencies() async {
    Get.putAsync(() async {
      final sharedPreferences = await SharedPreferences.getInstance();

      return AuthController(sharedPreferences: sharedPreferences);
    }, permanent: true);

    Get.put(
      ApiService(
        headers: () {
          final headers = {
            "Authorization": AppStrings.authorizationToken,
            "Accept": "application/json",
            "Content-Type": "application/json",
          };
          return headers;
        },
        onUnauthorized: () async {
          await Get.find<AuthController>().clearUserData();
          Get.offAllNamed(AppRoutes.onboarding);
        },
      ),
      permanent: true,
    );

    Get.put(MovieRepository(), permanent: true);
  }
}
