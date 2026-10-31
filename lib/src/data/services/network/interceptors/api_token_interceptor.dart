import 'package:cinephiler/src/data/services/network/endpoints.dart';
import 'package:dio/dio.dart';

/// Attaches the current Bearer access token to every outgoing request.
/// Nothing else, no refresh logic, no queue, no navigation.
class ApiTokenInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final apiKey = Endpoints.apiKey;

    options.headers["Authorization"] = "Bearer $apiKey";

    handler.next(options);
  }
}
