import 'package:dio/dio.dart';
import 'package:of_28_movie_review_app/features/shared/data/model/movie_response.dart';
import 'package:retrofit/retrofit.dart';

import '../../../features/movie_details/data/model/movie_details_model.dart';
import 'endpoints.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: Endpoints.baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl, ParseErrorLogger errorLogger}) =
      _RestClient;

  @GET(Endpoints.requestToken)
  Future<dynamic> getRequestToken();

  @GET(Endpoints.trendingUrl)
  Future<MovieResponse> trending();

  @GET(Endpoints.newlyReleased)
  Future<MovieResponse> newlyReleased();

  @GET(Endpoints.upcomingMovies)
  Future<MovieResponse> upcoming();

  @GET(Endpoints.movieById)
  Future<MovieDetailsModel> movieById(@Path("id") int id);

  @GET(Endpoints.searchMovieUrl)
  Future<MovieResponse> searchMovie(@Query("query") String query);

}
