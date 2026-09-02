import 'dart:async';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:retrofit/retrofit.dart';

class Api {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 100,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  static Future<void> call<T>({
    required Future<HttpResponse<T>> action,
    required FutureOr<void> Function(T response) onSuccess,
    required FutureOr<void> Function(String error) onError,
  }) async {
    final HttpResponse<T> result;

    try {
      result = await action;
    } catch (e, stackTrace) {
      if (e is DioException) {
        final request = e.requestOptions;
        final response = e.response;

        _logger.e(
          'DioException [${e.type}] ${request.method} ${request.uri}\n'
          'Status Code: ${response?.statusCode}\n'
          'Headers: ${request.headers}\n'
          'Request Body: ${request.data}\n'
          'Response Body: ${response?.data}',
          error: e,
          stackTrace: stackTrace,
        );

        if (response?.data != null) {
          final data = response!.data;

          if (data is Map<String, dynamic>) {
            final message = data['status_message'] ?? data['message'];
            if (message != null) {
              await onError(message.toString());
              return;
            }
          }
        }

        final errorMsg = e.message ?? e.toString();
        await onError(errorMsg);
        return;
      }

      // Generic fallback for unexpected error
      _logger.e('Unexpected Exception', error: e, stackTrace: stackTrace);
      await onError(e.toString());
      return;
    }

    // Business logic runs outside try-catch
    await onSuccess(result.data);
  }
}
