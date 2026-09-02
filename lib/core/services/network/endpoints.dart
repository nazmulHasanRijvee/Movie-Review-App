class Endpoints {
  static const baseUrl = String.fromEnvironment("BASE_URL");
  // static const communityBase = String.fromEnvironment("COMMUNITY_URL");

  static const String apiKey = String.fromEnvironment(
    "API_KEY",
    defaultValue: '',
  );
  static const String apiBearer = "Bearer $apiKey";

  // Authentication
  static const String requestToken = '/authentication/token/new';
  static const String oAuthLink = 'https://www.themoviedb.org/authenticate';
  static const String getSessionId = '/authentication/session/new';

  // log out and delete session id
  static const String deleteSessionId = '/authentication/session';

  // User Details
  static String getUserDetails(String sessionId) =>
      '$baseUrl/account/null?session_id=$sessionId';

  // Fetch an account detail using the account_id
  static String fetchAccountDetails(String? accountId) =>
      '$baseUrl/account/$accountId';

  static String get trendingUrl => '$baseUrl/trending/all/week';
  static String get newlyReleased => '$baseUrl/movie/now_playing';
  static String get upcomingMovies => '$baseUrl/movie/upcoming';

  static String getMovieById(int id) => '$baseUrl/movie/$id';

  static String searchMovieUrl(String query) =>
      '$baseUrl/search/movie?query=$query';
}
