import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'auth/token_manager.dart';
import 'endpoints.dart';
import 'interceptors/api_token_interceptor.dart';
import 'interceptors/unauthorized_interceptor.dart';

class DioClient extends GetxService {
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
      ApiTokenInterceptor(),
      UnauthorizedInterceptor(tokenManager: tokenManager),
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
