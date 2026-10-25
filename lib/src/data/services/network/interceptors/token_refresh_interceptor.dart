import 'package:dio/dio.dart';

import '../../../../core/logger/app_logger.dart';
import '../auth/token_manager.dart';

class TokenRefreshInterceptor extends Interceptor {
  TokenRefreshInterceptor({required this.tokenManager, required this.dio});

  final TokenManager tokenManager;
  final Dio dio;

  static const _retriedKey = 'auth.retried';

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (!_eligible(err)) return handler.next(err);

    if (await _tokenIsStale(err.requestOptions)) {
      return _replay(err, handler);
    }

    try {
      await tokenManager.refresh();
    } catch (refreshError, stackTrace) {
      AppLogger.error(
        "Token refresh failed",
        error: refreshError,
        stackTrace: stackTrace,
      );

      return handler.next(err);
    }

    return _replay(err, handler);
  }

  bool _eligible(DioException err) {
    final options = err.requestOptions;
    return err.response?.statusCode == 401 &&
        options.headers.containsKey('Authorization') &&
        options.extra[_retriedKey] != true &&
        options.data is! FormData;
  }

  Future<bool> _tokenIsStale(RequestOptions options) async {
    final current = await tokenManager.accessToken;
    if (current == null || current.isEmpty) return false;
    return options.headers['Authorization'] != 'Bearer $current';
  }

  Future<void> _replay(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final options = err.requestOptions..extra[_retriedKey] = true;
    try {
      handler.resolve(await dio.fetch<dynamic>(options));
    } on DioException catch (retryError) {
      handler.next(retryError);
    } catch (retryError) {
      handler.next(err.copyWith(error: retryError));
    }
  }
}