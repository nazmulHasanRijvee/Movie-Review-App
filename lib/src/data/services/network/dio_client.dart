import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'auth/token_manager.dart';
import 'endpoints.dart';
import 'interceptors/access_token_interceptor.dart';
import 'interceptors/token_refresh_interceptor.dart';

class DioClient extends GetxService {
  /// Creates a fully-wired [Dio] instance.
  ///
  /// Pass [tokenManager] explicitly so that [AppBindings] controls the wiring
  /// order. Interceptors are added in priority order:
  ///   1. [AccessTokenInterceptor]  – attaches Bearer token on every request.
  ///   2. [TokenRefreshInterceptor] – retries once after a silent refresh on 401.
  ///   3. [PrettyDioLogger]         – always last so it logs the final request.
  static Dio getInstance({required TokenManager tokenManager}) {
    final dio = Dio(
      BaseOptions(
        baseUrl: Endpoints.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.addAll([
      AccessTokenInterceptor(),
      TokenRefreshInterceptor(
        tokenManager: tokenManager,
        dio: dio,
      ),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
      ),
    ]);

    return dio;
  }
}

