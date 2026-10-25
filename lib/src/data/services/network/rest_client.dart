import 'package:dio/dio.dart';
import 'package:cinephiler/src/data/models/movie_response.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/movie_details_model.dart';
import 'endpoints.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: Endpoints.baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl, ParseErrorLogger errorLogger}) =
      _RestClient;

  // Authentication
  @GET(Endpoints.requestToken)
  Future<dynamic> getRequestToken();

  // Movies
  @GET(Endpoints.trendingUrl)
  Future<MovieResponse> trending();

  @GET(Endpoints.newlyReleased)
  Future<MovieResponse> newlyReleased();

  @GET(Endpoints.upcomingMovies)
  Future<MovieResponse> upcoming();

  // Fetch Movie Details by ID
  @GET(Endpoints.movieById)
  Future<MovieDetailsModel> movieById(@Path("id") int id);

  // Search Movies
  @GET(Endpoints.searchMovieUrl)
  Future<MovieResponse> searchMovie(@Query("query") String query);
}
