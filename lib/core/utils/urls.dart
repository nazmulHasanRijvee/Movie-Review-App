class Urls {

  Urls._();

  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  // Authentication
  static const String requestToken = '$baseUrl/authentication/token/new';
  static const String oAuthLink = 'https://www.themoviedb.org/authenticate';
  static const String getSessionId = '$baseUrl/authentication/session/new';

  // User Details
  static String getUserDetails(String sessionId) => '$baseUrl/account/null?session_id=$sessionId';
  // /account/null?session_id

  // Fetch an account detail using the account_id
  static String fetchAccountDetails(String? accountId) => '$baseUrl/account/$accountId';


  static const String trendingUrl = '$baseUrl/trending/all/week';
  static const String newlyReleased = '$baseUrl/movie/now_playing';
  static const String upcomingMovies = '$baseUrl/movie/upcoming';

  static String getMovieById(int id) => '$baseUrl/movie/$id';

  static String searchMovieUrl (String query) => '$baseUrl/search/movie?query=$query';

}