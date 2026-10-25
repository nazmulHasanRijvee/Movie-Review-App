import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../auth/auth_service.dart';
import 'endpoints.dart';
import 'interceptors/access_token_interceptor.dart';
import 'interceptors/token_refresh_interceptor.dart';

class DioClient extends GetxService {
  static Dio getInstance() {
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

    final authService = Get.find<AuthService>();

    dio.interceptors.addAll([
      AccessTokenInterceptor(
        // onRequest: attach token
        authService: authService,
      ),
      TokenRefreshInterceptor(
        // onError: refresh token
        baseUrl: Endpoints.baseUrl,
        refreshTokenEndpoint:
            Endpoints.baseUrl, // add your refresh token endpoint here
        authService: authService,
        navigatorKey:
            GlobalKey<NavigatorState>(), // Use the global navigator key
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
        enabled: kDebugMode, // Enable logging only in debug mode
      ), // always last
    ]);

    return dio;
  }
}
