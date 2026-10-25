import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../../core/logger/app_logger.dart';
import 'token_store.dart';

/// Owns the application's access and refresh tokens.
///
/// [TokenManager] does not perform authentication or refresh requests. The
/// refresh interceptor owns that flow; this class only loads, exposes, saves,
/// updates, and clears tokens for the rest of the app.
/// Token storage with session-change notifications for Riverpod. It contains
/// no refresh HTTP logic; the refresh interceptor owns that flow.
class TokenManager extends GetxService {
  TokenManager({
    required TokenStore store,
    required String refreshBaseUrl,
    required String refreshEndpoint,
  }) : _refreshDio = Dio(
          BaseOptions(
           baseUrl: refreshBaseUrl,
           connectTimeout: const Duration(seconds: 15),
           receiveTimeout: const Duration(seconds: 15),
          ),
        ),

       _store = store,

       _refreshEndpoint = refreshEndpoint
       
       {
    _ready = _loadTokens();
  }

  final TokenStore _store;
  final String _refreshEndpoint;
  final Dio _refreshDio;
  final StreamController<bool> _sessionController =
      StreamController<bool>.broadcast();
  late final Future<void> _ready;
  String? _accessToken;
  String? _refreshToken;
  Completer<String>? _inflightRefresh;
  int _sessionEpoch = 0;

  Stream<bool> get sessionStream => _sessionController.stream.distinct();


  Future<String?> get accessToken async {
    await _ready;
    return _accessToken;
  }

  Future<String?> get refreshToken async {
    await _ready;
    return _refreshToken;
  }

  bool get hasSession => _refreshToken != null;

  Future<void> saveTokens({required String access, String? refresh}) async {
    await _ready;

    await _store.write(TokenKey.access, access);

    if (refresh != null && refresh.isNotEmpty) await _store.write(TokenKey.refresh, refresh);

    _accessToken = access;
    if (refresh != null && refresh.isNotEmpty) _refreshToken = refresh;

    _sessionController.add(true);
  }


  Future<void> clearSession() async {
    _sessionEpoch++; // Immediately invalidates any in-flight refresh
    await _ready;
    await _store.clear();
    _accessToken = null;
    _refreshToken = null;
    _sessionController.add(false);
  }

  /// Closes the session broadcast controller and _refreshDio's socket pool.
  @override
  void onClose() {
    _refreshDio.close();
    _sessionController.close();
  }

  /// Refreshes the access token. Concurrent callers share one HTTP roundtrip.
  Future<String> refresh() async {
    await _ready;

    final existing = _inflightRefresh;
    if (existing != null) return existing.future;

    final completer = Completer<String>();
    _inflightRefresh = completer;
    unawaited(_runRefresh(completer));
    return completer.future;
  }

  Future<void> _runRefresh(Completer<String> completer) async {
    try {
      final newAccess = await _performRefresh();

      completer.complete(newAccess);

    } catch (e, stackTrace) {
      if (_isAuthDefinitive(e)) await clearSession();

      completer.completeError(e, stackTrace);
    } finally {
      _inflightRefresh = null;
    }
  }

  /// Only an explicit rejection of the refresh token counts as "session
  /// dead." Timeouts, 5xx, connection errors prove nothing about the token
  /// so keep the session and let the caller's request fail this once.
  bool _isAuthDefinitive(Object error) {
    if (error is DioException && error.type == DioExceptionType.badResponse) {
      return switch (error.response?.statusCode) {
        400 || 401 || 403 => true,
        _ => false,
      };
    }

    return false;
  }

  Future<String> _performRefresh() async {
    final startEpoch = _sessionEpoch; // 2. Capture epoch before network call

    final refreshToken = _refreshToken;
    if (refreshToken == null || refreshToken.isEmpty) {
      throw StateError('No refresh token available');
    }

    final response = await _refreshDio.post<dynamic>(
      _refreshEndpoint,
      data: {'refreshToken': refreshToken},
    );

    // 3. Check if a logout occurred while waiting for the response
    if (_sessionEpoch != startEpoch) {
      throw StateError('Session invalidated during refresh');
    }

    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw FormatException('Refresh response was not a JSON object');
    }

    final newAccess = data['accessToken'];
    if (newAccess is! String || newAccess.isEmpty) {
      throw FormatException('Refresh response missing accessToken');
    }

    // Refresh token rotation: if the backend issues a new refresh token,
    // saveTokens() persists both. If omitted or null, the existing refresh token
    // is safely preserved.
    final newRefresh = data['refreshToken'] is String
        ? data['refreshToken'] as String
        : null;
    await saveTokens(access: newAccess, refresh: newRefresh);

    return newAccess;
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