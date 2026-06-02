import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:http/http.dart';
import 'package:of_28_movie_review_app/core/app_strings.dart';

class ApiService extends GetxService{

  Future<ApiResponse> getRequest ({required String url}) async {

    try {

      Uri uri = Uri.parse(url);
      debugPrint('URL => $url');

      final response = await get(uri, headers: {
        'Accept': 'application/json',
        'Authorization' : AppStrings.authorizationToken
      }).timeout(const Duration(seconds: 15)); // Set a timeout for the request



      final int statusCode = response.statusCode;
      final decodedData = jsonDecode(response.body);

      debugPrint('URL => $url\nBody => $decodedData');
      if (statusCode == 200) {

        return ApiResponse(
            body: decodedData, statusCode: statusCode, isSuccess: true
        );
      } else if (response.statusCode == 401){

        return ApiResponse(
            body: decodedData, statusCode: statusCode, isSuccess: false, errorMessage: 'Unauthorized plz provide API key'
        );
      } else {
        debugPrint('Error response status code: $statusCode\n body => ${response.body}'); // Log the error response body for debugging
        return ApiResponse(
            body: decodedData, statusCode: statusCode, isSuccess: false, errorMessage: decodedData['status_message']
        );
      }
    } catch (e) {
      return ApiResponse(statusCode: 000, body: null, isSuccess: false, errorMessage: e.toString());
    }

  }

  static Future<ApiResponse> postRequest ({required String url, required Map<String, dynamic>? body}) async {

    try {

      debugPrint('URL => $url\nBody => $body');

      Uri uri = Uri.parse(url);

      final headers = {
        "Accept": 'application/json',
        'Authorization' : AppStrings.authorizationToken
      };

      final Response response = await post(
          uri,
          headers: headers,
          body: body != null ? jsonEncode(body) : null
      ).timeout(const Duration(seconds: 15)); // Set a timeout for the request


      final int statusCode = response.statusCode;
      final decodedData = jsonDecode(response.body);

      debugPrint('URL => $url\nBody => $decodedData');

      if (statusCode == 200 || statusCode == 201) {

        return ApiResponse(
            body: decodedData, statusCode: statusCode, isSuccess: true
        );
      } else if (response.statusCode == 401){

        return ApiResponse(
            body: decodedData, statusCode: statusCode, isSuccess: false, errorMessage: 'Unauthorized'
        );
      } else {
        return ApiResponse(
            body: decodedData, statusCode: statusCode, isSuccess: false
        );
      }
    } catch (e) {
      return ApiResponse(statusCode: 000, body: null, isSuccess: false, errorMessage: e.toString());
    }

  }

}

class ApiResponse {

  final bool isSuccess;
  final int statusCode;
  final dynamic body;
  final String? errorMessage;

  ApiResponse({
    required this.isSuccess,
    required this.statusCode,
    required this.body,
    this.errorMessage = 'Showing error from ApiResponse model'
  });


}