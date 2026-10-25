import 'package:cinephiler/src/data/repsoitories/auth_repository_impl.dart';
import 'package:cinephiler/src/presentation/core/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/app_strings.dart';
import '../../../data/repsoitories/movie_repository_impl.dart';
import '../../../data/services/api_service.dart';
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

    // 
    Get.put<AuthRepositoryImpl>(
      AuthRepositoryImpl(
        cacheService: Get.find<CacheService>(),
      ),
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
        }
      ),
      permanent: true,
    );

    // Networking
    // DioClient receives TokenManager so interceptors are fully wired.
    final dio = DioClient.getInstance(tokenManager: tokenManager);
    Get.put<RestClient>(RestClient(dio), permanent: true);

    Get.put<ApiService>(
      ApiService(
        headers: () => {
          'Authorization': AppStrings.authorizationToken,
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        // On 401: clear session, remove cached user, and redirect to onboarding with alert.
        onUnauthorized: () => tokenManager.clearSession(notifyExpired: true),
      ),
      permanent: true,
    );

    // Repositories
    Get.put<MovieRepositoryImpl>(MovieRepositoryImpl(), permanent: true);
  }
}
