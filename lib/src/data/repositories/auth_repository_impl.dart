import 'dart:convert';

import 'package:get/get.dart';

import '../../core/logger/app_logger.dart';
import '../models/user_model.dart';
import '../services/cache/cache_service.dart';
import '../services/network/api_handler.dart';
import '../services/network/auth/token_manager.dart';
import '../services/network/rest_client.dart';

class AuthRepositoryImpl extends GetxService {
  AuthRepositoryImpl({
    required this.cacheService,
    required this.restClient,
    required this.tokenManager,
  }) {
    getUserData();
  }

  final CacheService cacheService;
  final RestClient restClient;
  final TokenManager tokenManager;
  UserModel? _userModel;

  UserModel? get user => _userModel;

  Future<bool> login(String requestToken) async {
    bool isSuccess = false;

    await Api.call(
      action: restClient.login(request: {"request_token": requestToken.trim()}),

      onSuccess: (data) async {
        AppLogger.info("${data["session_id"]}");

        isSuccess = await fetchUserData(data["session_id"]);
      },

      onError: (msg) {
        AppLogger.error("Login error: $msg");
      },
    );

    return isSuccess;
  }

  Future<bool> fetchUserData(String sessionId) async {
    bool isSuccess = false;

    await Api.call(
      action: restClient.fetchUser(sessionId),

      onSuccess: (data) async {
        await saveUserData(data);
        await tokenManager.saveTokens(access: sessionId);

        isSuccess = true;
      },

      onError: (msg) {
        AppLogger.error("Fetch user error: $msg");
      },
    );

    return isSuccess;
  }

  Future<bool> logOut() async {
    final sessionId = await tokenManager.accessToken;

    if (sessionId != null) {
      await Api.call(
        action: restClient.deleteSession({"session_id": sessionId}),

        onSuccess: (_) {},

        onError: (msg) {
          AppLogger.error("Failed to delete remote session: $msg");
        },
      );
    }

    await clearUserData();
    await tokenManager.clearSession();

    return true;
  }

  Future<void> saveUserData(UserModel model) async {
    await cacheService.save<String>(CacheKey.user, jsonEncode(model.toJson()));
    _userModel = model;
  }

  Future<void> getUserData() async {
    final userData = cacheService.get<String>(CacheKey.user);

    if (userData != null) {
      _userModel = UserModel.fromJson(jsonDecode(userData));
    }
  }

  Future<void> clearUserData() async {
    await cacheService.remove([CacheKey.user]);
    _userModel = null;
  }
}
