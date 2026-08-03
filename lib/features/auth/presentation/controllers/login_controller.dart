import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:of_28_movie_review_app/core/services/api_service.dart';
import 'package:of_28_movie_review_app/core/services/deep_link_services.dart';
import 'package:of_28_movie_review_app/core/services/url_launcher_service.dart';

import '../../../../app/controllers/auth_controller.dart';
import '../../../../core/utils/urls.dart';
import '../../../shared/data/model/user_model.dart';

class LoginController extends GetxController {

  // For showing loading state when OAuth is in progress
  final RxBool _isLoading = false.obs;
  String? errorMessage;

  // To control when startAuth should be finished or completed with a value
  Completer<bool>? _authCompleter;

  // StreamSubscription to listen for Deep Links while app is running
  StreamSubscription<Uri>? streamSubscription;

  // Dependency Injection
  UrlLauncherService get _urlLauncherService => Get.find<UrlLauncherService>();
  DeepLinkServices get _deepLinkServices => Get.find<DeepLinkServices>();
  ApiService get _apiService => Get.find<ApiService>();
  AuthController get _authController => Get.find<AuthController>();

  // getter methods to ensure encapsulation
  bool get isLoading => _isLoading.value;
  String? get error => errorMessage;

  /// Takes a request_token, launches the OAuth URL for validating the token,
  // listens for Deep Links using app_links plugin and completes with a bool value
  // when _authCompleter?.complete(...) is called
  Future<bool> startAuthentication(String requestToken) async {

    _isLoading.value = true;
    _authCompleter = Completer<bool>();

    // Prevent duplicate Stream listeners
    await streamSubscription?.cancel();

    streamSubscription = _deepLinkServices.uriStream
        .listen(_handleAuthDeepLink);

    await _urlLauncherService.launchAuthUrl(requestToken);

    final initialUri = await _deepLinkServices.initialUri;
    if(initialUri != null){
      _handleAuthDeepLink(initialUri);
    }

    return _authCompleter!.future;

  }

  /// Handle Deep Links, parse the link and if approved then Call the API for exchanging
  // the request_token for a session_id and save it in the AuthController
  // and If succeeds complete the _authCompleter with true else false
  Future<void> _handleAuthDeepLink(Uri uri) async {

    if(uri.host != 'auth') return;

    final approved = uri.queryParameters['approved'];

    final requestToken = uri.queryParameters['request_token'];

    debugPrint('${uri.queryParametersAll}');

    if(approved != 'true' || requestToken == null) {
      await _stopAuth();
      _completeAuth(false);
      return;
    }

    final response = await _apiService.postRequest(
        url: Urls.getSessionId,
        body: {
          "request_token" : requestToken.trim()
        }
    );

    if(response.isSuccess) {
      await getUserData(response.body['session_id']);
      debugPrint('Session ID: ${response.body['session_id']}');
    }

    await _stopAuth();

    _completeAuth(response.isSuccess);
  }

  /// Helper method toc clean up when auth process is  stopped. Sets the
  // loading to false, cancels the stream subscription and sets it to null,
  // ensuring no duplicate streams
  Future<void> _stopAuth() async {

    _isLoading.value = false;

    // Stop listening, clean up Stream to prevent memory leak
    await streamSubscription?.cancel();
    streamSubscription = null;
  }

  /// Helper method to complete the _authCompleter (startAuth method) with a value
  // if it isn't completed yet
  void _completeAuth(bool success) {
    // if completer is not null and not completed, then complete it
    if (!(_authCompleter?.isCompleted ?? true)) {
      _authCompleter?.complete(success);
    }
  }

  Future<void> getUserData(String sessionId) async {

    // Get user details
    final apiResponse = await _apiService.getRequest(
        url: Urls.getUserDetails(sessionId)
    );

    if(!apiResponse.isSuccess) {
      debugPrint('Error getting user details, ${apiResponse.statusCode}');
      return;
    }

    // Save session id and user details in the AuthController
    final UserModel user = UserModel.fromJson(apiResponse.body);
    await _authController.saveUserData(user, sessionId);

  }

  @override
  void onClose() {
    // Cancel the stream subscription when the GetxController is closed or disposed
    streamSubscription?.cancel();
    super.onClose();
  }

}