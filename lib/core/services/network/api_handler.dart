import 'dart:async';
import 'package:dio/dio.dart';

import '../../logger/app_logger.dart';

class Api {
  static Future<void> call<T>({
    required Future<T> action,
    required FutureOr<void> Function(T response) onSuccess,
    required FutureOr<void> Function(String error) onError,
  }) async {
    final T result;

    try {
      result = await action;
    } on DioException catch (e, stackTrace) {
      // 1. DioExceptioin occured and Backend returned a JSON map with 'message'
      final request = e.requestOptions;
      final response = e.response;
      final data = request.data;

      AppLogger.error(
        'DioException [${e.type}] ${request.method} ${request.uri}\n'
        'Status Code: ${response?.statusCode}\n'
        'Headers: ${request.headers}\n'
        'Request Body: ${request.data}\n'
        'Response Body: ${response?.data}',
        error: e,
        stackTrace: stackTrace,
      );

      // Check if the backend returned a JSON map with a 'message' field
      if (data != null && data is Map<String, dynamic>) {
        final message = data['status_message'] ?? data['message'];
        // if "message" is not null, call onError with the message and stop further processing
        if (message != null) {
          await onError(message.toString());
          return;
        }
      }

      // If the backend did not return a 'message', use the DioException's message or a generic error message
      final errorMsg = e.message ?? e.toString();
      await onError(errorMsg);
      return;
    } catch (e, stackTrace) {
      // Generic fallback for unexpected errors like fromJson failures, TypeErors,
      // Anything Dio didn't wrap
      AppLogger.error('Unexpected Exception', error: e, stackTrace: stackTrace);
      await onError(e.toString());
      return;
    }

    // Business logic runs outside try-catch
    await onSuccess(result);
  }
}
