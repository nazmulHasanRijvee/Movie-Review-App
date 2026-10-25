import 'package:dio/dio.dart';

import '../auth/token_manager.dart';

/// Attaches the current Bearer access token to every outgoing request.
/// Nothing else, no refresh logic, no queue, no navigation.
class AccessTokenInterceptor extends Interceptor {
  AccessTokenInterceptor({required this.tokenManager});

  final TokenManager tokenManager;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await tokenManager.accessToken;
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
