import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/app_strings.dart';
import '../../../data/repsoitories/movie_repository_impl.dart';
import '../../../data/services/api_service.dart';
import '../../../data/services/auth/auth_service.dart';
import '../../../data/services/auth_controller.dart';
import '../../../data/services/cache/cache_service.dart';
import '../../../data/services/network/auth/secure_token.dart';
import '../../../data/services/network/auth/token_manager.dart';
import '../../../data/services/network/auth/token_store.dart';
import '../../../data/services/network/dio_client.dart';
import '../../../data/services/network/endpoints.dart';
import '../../../data/services/network/rest_client.dart';
import '../routes/app_routes.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    final sharedPreferences = Get.find<SharedPreferences>();

    // Cache
    Get.put<CacheService>(
      SharedPreferencesService(sharedPreferences),
      permanent: true,
    );

    // Auth service (lightweight cache-backed layer)
    Get.put<AuthService>(
      AuthService(cache: Get.find<CacheService>()),
      permanent: true,
    );

    // Legacy AuthController (SharedPreferences-backed)
    Get.put<AuthController>(
      AuthController(sharedPreferences: sharedPreferences),
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
      ),
      permanent: true,
    );

    // Session guard — single source of truth for logout navigation.
    // TokenManager emits false on sessionStream whenever clearSession() is
    // called: explicit logout, or a definitively failed token refresh (400/401/403).
    // GetX streams are automatically cleaned up when the app scope is closed.
    tokenManager.sessionStream.listen((isActive) {
      if (!isActive && Get.currentRoute != AppRoutes.onboarding) {
        Get.offAllNamed(AppRoutes.onboarding);
      }
    });

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
        // Explicit logout: clear session → sessionStream fires → guard navigates.
        onUnauthorized: () => tokenManager.clearSession(),
      ),
      permanent: true,
    );

    // Repositories
    Get.put<MovieRepositoryImpl>(MovieRepositoryImpl(), permanent: true);
  }
}
