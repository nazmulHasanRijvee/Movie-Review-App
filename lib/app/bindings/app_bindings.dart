import 'package:get/get.dart';
import 'package:of_28_movie_review_app/app/controllers/auth_controller.dart';
import 'package:of_28_movie_review_app/core/services/auth/auth_service.dart';
import 'package:of_28_movie_review_app/core/services/cache/cache_service.dart';
import 'package:of_28_movie_review_app/core/services/network/dio_client.dart';
import 'package:of_28_movie_review_app/core/services/network/rest_client.dart';
import 'package:of_28_movie_review_app/features/movie_details/data/repositories/movie_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/app_strings.dart';
import '../../core/services/api_service.dart';
import '../routes/app_routes.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    final sharedPreferences = Get.find<SharedPreferences>();

    Get.put<CacheService>(
      SharedPreferencesService(sharedPreferences),
      permanent: true,
    );

    Get.put<AuthService>(
      AuthService(cache: Get.find<CacheService>()),
      permanent: true,
    );

    Get.put<AuthController>(
      AuthController(sharedPreferences: sharedPreferences),
      permanent: true,
    );

    final dio = DioClient.getInstance();
    Get.put<RestClient>(RestClient(dio), permanent: true);

    Get.put<ApiService>(
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

    Get.put<MovieRepository>(MovieRepository(), permanent: true);
  }
}
