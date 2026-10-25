import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/services/network/auth/token_manager.dart';
import '../routes/app_routes.dart';

/// Route guard that prevents unauthenticated users from accessing protected screens.
class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    if (!Get.isRegistered<TokenManager>()) {
      return const RouteSettings(name: AppRoutes.onboarding);
    }

    final tokenManager = Get.find<TokenManager>();
    final isLoggedIn = tokenManager.hasSessionSync;

    return isLoggedIn ? null : const RouteSettings(name: AppRoutes.onboarding);
  }
}
