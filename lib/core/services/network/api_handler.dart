import 'dart:async';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

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
    required Future<T> action,
    required FutureOr<void> Function(T response) onSuccess,
    required FutureOr<void> Function(String error) onError,
  }) async {
    final T result;

    try {
      result = await action;
    } on DioException catch (e, stackTrace) {
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
    } catch (e, stackTrace) {
      //Generic fallback for unexpected errors like fromJson failures, TypeErors,
      // Anything Dio didn't wrap
      _logger.e('Unexpected Exception', error: e, stackTrace: stackTrace);
      await onError(e.toString());
      return;
    }

    // Business logic runs outside try-catch
    await onSuccess(result);
  }
}
