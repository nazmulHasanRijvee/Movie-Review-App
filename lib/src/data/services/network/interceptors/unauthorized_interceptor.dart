import 'package:dio/dio.dart';

import '../../../../core/logger/app_logger.dart';
import '../auth/token_manager.dart';

class UnauthorizedInterceptor extends Interceptor {
  UnauthorizedInterceptor({required this.tokenManager});

  final TokenManager tokenManager;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final statusCode = err.response?.statusCode;

    final data = err.response?.data;
    final code = data is Map ? data["status_code"] : null;
    final isSessionError = code == 3 || code == 17;
    
    final hadSessionParam = err.requestOptions.queryParameters.containsKey("session_id");

    if (statusCode == 401 && isSessionError && hadSessionParam) {
      AppLogger.error("Unauthorized session cleared");
      await tokenManager.clearSession(notifyExpired: true);
    }

    handler.next(err);
  }
}
