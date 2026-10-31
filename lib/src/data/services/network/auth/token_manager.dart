import 'dart:async';

import 'package:get/get.dart';

import '../../../../core/logger/app_logger.dart';
import 'token_store.dart';

class TokenManager {
  TokenManager({required TokenStore store, this.onSessionExpired})
    : _store = store {
    _ready = _loadTokens();
  }

  final TokenStore _store;
  final FutureOr<void> Function()? onSessionExpired;
  late final Future<void> _ready;
  String? _accessToken;
  String? _refreshToken;

  Future<String?> get accessToken async {
    await _ready;
    return _accessToken;
  }

  Future<String?> get refreshToken async {
    await _ready;
    return _refreshToken;
  }

  Future<bool> get hasSession async {
    await _ready;
    return _accessToken != null;
  }

  /// Synchronous in-memory check (true if an access or refresh token is loaded).
  /// Safe to use in [GetMiddleware.redirect] after initial app initialization.
  bool get hasSessionSync => _accessToken != null || _refreshToken != null;

  Future<void> saveTokens({required String access, String? refresh}) async {
    await _ready;

    await _store.write(TokenKey.access, access);

    if (refresh != null && refresh.isNotEmpty) await _store.write(TokenKey.refresh, refresh);

    _accessToken = access;
    if (refresh != null && refresh.isNotEmpty) _refreshToken = refresh;
  }

  Future<void> clearSession({bool notifyExpired = false}) async {
    await _ready;
    final hadSession = _accessToken != null;
    await _store.clear();

    _accessToken = null;
    _refreshToken = null;

    if (notifyExpired && hadSession) {
      await onSessionExpired?.call();
    }
  }

  Future<void> _loadTokens() async {
    try {
      _accessToken = await _store.read(TokenKey.access);
      _refreshToken = await _store.read(TokenKey.refresh);
    } catch (error, stackTrace) {
      AppLogger.error(
        "TokenManager._loadTokens failed",
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
