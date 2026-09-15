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

  static const String trendingUrl = '/trending/all/week';
  static const String newlyReleased = '/movie/now_playing';
  static const String upcomingMovies = '/movie/upcoming';

  static const String movieById = '/movie/{id}';

  static const String searchMovieUrl = '/search/movie';
}
