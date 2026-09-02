import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'endpoints.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: Endpoints.baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl, ParseErrorLogger errorLogger}) =
      _RestClient;

  @GET(Endpoints.requestToken)
  Future<HttpResponse> getRequestToken();

  // @POST(Endpoints.register)
  // Future<HttpResponse> register(@Body() Map<String, dynamic> request);

  // @POST(Endpoints.login)
  // Future<HttpResponse> login(@Body() Map<String, dynamic> request);

  // @POST(Endpoints.forgotPassword)
  // Future<HttpResponse> forgotPassword(@Body() Map<String, dynamic> request);
}
