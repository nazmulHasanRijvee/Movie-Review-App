import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:of_28_movie_review_app/core/services/api_service.dart';
import 'package:of_28_movie_review_app/core/services/deep_link_services.dart';
import 'package:of_28_movie_review_app/core/services/url_launcher_service.dart';

import '../../../../core/utils/urls.dart';

class LoginController extends GetxController{

  // For showing loading state when OAuth is in progress
  final RxBool _isLoading = false.obs;
  String? errorMessage;

  // To control when startAuth should be finished or completed with a value
  Completer<bool>? _authCompleter;

  // StreamSubscription to listen for Deep Links while app is running
  StreamSubscription<Uri>? streamSubscription;

  // Dependency Injection
  UrlLauncherService get urlLauncherService => Get.find<UrlLauncherService>();
  DeepLinkServices get deepLinkServices => Get.find<DeepLinkServices>();
  ApiService get apiService => Get.find<ApiService>();

  // getter methods to ensure encapsulation
  bool get isLoading => _isLoading.value;
  String? get error => errorMessage;

  /// Takes a request_token, using OAuth validates the request_token,
  // listens for Deep Links using app_links plugin and calls an API to exchange the
  // request_token for a session_id. If it succeeds saves the session_id in the AuthController
  Future<bool> startAuthentication(String requestToken) async {

    _isLoading.value = true;
    _authCompleter = Completer<bool>();

    // Prevent duplicate Stream listeners
    await streamSubscription?.cancel();

    streamSubscription = deepLinkServices.uriStream
        .listen(_handleAuthDeepLink);

    await urlLauncherService.launchAuthUrl(requestToken);

    final initialUri = await deepLinkServices.initialUri;
    if(initialUri != null){
      _handleAuthDeepLink(initialUri);
    }

    return _authCompleter!.future;

  }

  // Handle Deep Links, parse the link and if approved then Call the API for exchanging
  // the request_token for a session_id and save it in the AuthController
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

    final response = await apiService.postRequest(
        url: Urls.getSessionId,
        body: {
          "request_token" : requestToken.trim()
        }
    );

    if(response.isSuccess) {
      // Save session id to auth controller
      debugPrint('Session ID: ${response.body['session_id']}');
    }

    await _stopAuth();

    _completeAuth(response.isSuccess);
  }

  Future<void> _stopAuth() async {

    _isLoading.value = false;

    // Stop listening, clean up Stream to prevent memory leak
    await streamSubscription?.cancel();
    streamSubscription = null;
  }

  void _completeAuth(bool success) {
    // if completer is not null and not completed, then complete it
    if (!(_authCompleter?.isCompleted ?? true)) {
      _authCompleter?.complete(success);
    }
  }

  @override
  void onClose() {
    // Cancel the stream subscription when the GetxController is closed or disposed
    streamSubscription?.cancel();
    super.onClose();
  }

}