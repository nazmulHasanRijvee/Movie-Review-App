import 'package:cinephiler/src/data/repositories/auth_repository_impl.dart';
import 'package:cinephiler/src/presentation/core/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/repositories/movie_repository_impl.dart';
import '../../../data/services/cache/cache_service.dart';
import '../../../data/services/network/auth/secure_token.dart';
import '../../../data/services/network/auth/token_manager.dart';
import '../../../data/services/network/auth/token_store.dart';
import '../../../data/services/network/dio_client.dart';
import '../../../data/services/network/endpoints.dart';
import '../../../data/services/network/rest_client.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    final sharedPreferences = Get.find<SharedPreferences>();

    // Cache
    Get.put<CacheService>(
      SharedPreferencesService(sharedPreferences),
      permanent: true,
    );

    // Secure token storage & TokenManager
    Get.put<TokenStore>(
      SecureTokenStore(),
      permanent: true,
    );

    final tokenManager = Get.put<TokenManager>(
      TokenManager(
        store: Get.find<TokenStore>(),
        refreshBaseUrl: Endpoints.base,
        refreshEndpoint: Endpoints.refreshToken,
        onSessionExpired: () async {
          await Get.find<AuthRepositoryImpl>().clearUserData();

          if (Get.currentRoute != AppRoutes.onboarding) {
            Get.offAllNamed(AppRoutes.onboarding);
            Get.snackbar('Session Expired', 'Please sign in again.');
          }
        },
      ),
      permanent: true,
    );

    // Networking
    // DioClient receives TokenManager so interceptors are fully wired.
    final dio = DioClient.getInstance(tokenManager: tokenManager);
    Get.put<RestClient>(RestClient(dio), permanent: true);

    // 
    Get.put<AuthRepositoryImpl>(
      AuthRepositoryImpl(
        cacheService: Get.find<CacheService>(),
        restClient: Get.find<RestClient>(),
        tokenManager: Get.find<TokenManager>()
      ),
      permanent: true,
    );


    // Repositories
    Get.put<MovieRepositoryImpl>(MovieRepositoryImpl(), permanent: true);
  }
}
