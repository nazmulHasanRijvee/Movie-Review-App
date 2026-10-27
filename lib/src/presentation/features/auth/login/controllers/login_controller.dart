import 'dart:async';

import 'package:cinephiler/src/data/repositories/auth_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cinephiler/src/data/services/deep_links/deep_link_services.dart';
import 'package:cinephiler/src/data/services/url_launcher/url_launcher_service.dart';


class LoginController extends GetxController {
  final RxBool _isLoading = false.obs;
  String? errorMessage;

  // To control when startAuth should be finished or completed with a value
  Completer<bool>? _authCompleter;

  // StreamSubscription to listen for Deep Links while app is running
  StreamSubscription<Uri>? streamSubscription;

  /// Lifecycle observer.
  AppLifecycleListener? _lifecycleListener;

  /// Whether the app went to the background while OAuth was running.
  bool _appWentToBackground = false;
  /// Whether we received the OAuth callback.
  bool _callbackReceived = false;

  // DI
  UrlLauncherService get _urlLauncherService => Get.find<UrlLauncherService>();
  DeepLinkServices get _deepLinkServices => Get.find<DeepLinkServices>();
  AuthRepositoryImpl get _authRepo => Get.find<AuthRepositoryImpl>();

  bool get isLoading => _isLoading.value;
  String? get error => errorMessage;

  /// Takes a request_token, launches the OAuth URL for validating the token,
  // listens for Deep Links using app_links plugin and completes with a bool value
  // when _authCompleter?.complete(...) is called
  Future<bool> startAuthentication(String requestToken) async {
    /// Prevent starting another OAuth flow while one is already running
    if (_isLoading.value) return false;

    // Reset OAuth state.
    _appWentToBackground = false;
    _callbackReceived = false;

    _isLoading.value = true;
    _authCompleter = Completer<bool>();

    /// Listen for app lifecycle changes
    _startLifecycleListener();

    // Prevent duplicate Stream listeners
    await streamSubscription?.cancel();

    streamSubscription = _deepLinkServices.uriStream.listen(
      _handleAuthDeepLink,
    );

    await _urlLauncherService.launchAuthUrl(requestToken);

    final initialUri = await _deepLinkServices.initialUri;
    if (initialUri != null) {
      _handleAuthDeepLink(initialUri);
    }

    return _authCompleter!.future;
  }

  /// Handle Deep Links, parse the link and if approved then Call the API for exchanging
  // the request_token for a session_id and save it in the AuthController
  // and If succeeds complete the _authCompleter with true else false
  Future<void> _handleAuthDeepLink(Uri uri) async {
    if (!_isLoading.value) return;

    if (uri.host != 'auth') return;

    /// We received our OAuth callback
    _callbackReceived = true;

    final approved = uri.queryParameters['approved'];

    final requestToken = uri.queryParameters['request_token'];

    if (approved != 'true' || requestToken == null) {
      await _stopAuth();
      _completeAuth(false);
      return;
    }

    final isSuccess = await _authRepo.login(requestToken);

    await _stopAuth();

    _completeAuth(isSuccess);
  }

  void _startLifecycleListener() {
    // Dispose an old listener if one somehow exists.
    _lifecycleListener?.dispose();

    _lifecycleListener = AppLifecycleListener(
      onStateChange: _handleLifecycleState,
    );
  }

  void _handleLifecycleState(AppLifecycleState state) {
    if (!_isLoading.value) return;

    // User leaves our app and enters the browser.
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _appWentToBackground = true;

      debugPrint('OAuth: App went to background');

      return;
    }

    // User comes back to our app.
    if (state == AppLifecycleState.resumed) {
      // If the OAuth callback already arrived, don't cancel it.
      if (_callbackReceived) {
        return;
      }

      // The app was backgrounded while OAuth was running,
      // but no callback arrived.
      // This most likely means the user pressed Back / Cancelled
      // the browser OAuth flow.
      if (_appWentToBackground) {
        _stopAuth();

        _completeAuth(false);
      }
    }
  }

  /// Helper method toc clean up when auth process is  stopped. Sets the
  // loading to false, cancels the stream subscription and sets it to null,
  // ensuring no duplicate streams
  Future<void> _stopAuth() async {
    _isLoading.value = false;

    // Stop listening, clean up Stream to prevent memory leak
    await streamSubscription?.cancel();
    streamSubscription = null;

    // Stop listening for app lifecycle changes
    _lifecycleListener?.dispose();
    _lifecycleListener = null;
  }

  /// Helper method to complete the _authCompleter (startAuth method) with a value
  // if it isn't completed yet
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
    _lifecycleListener?.dispose();
    super.onClose();
  }
}
