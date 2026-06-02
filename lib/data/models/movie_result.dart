import 'package:of_28_movie_review_app/data/models/movie_details_model.dart';

class MovieResult {

  final MovieDetailsModel? movieDetailsModel;
  final String? errorMessage;

  MovieResult({this.movieDetailsModel, this.errorMessage});

  bool get isSuccess => movieDetailsModel != null;

}