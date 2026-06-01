class Urls {

  Urls._();

  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  static const String trendingUrl = '$baseUrl/trending/all/week';

  static String getMovieById(int id) => '$baseUrl/movie/$id';

  static String searchMovieUrl (String query) => '$baseUrl/search/movie?query=$query';

}