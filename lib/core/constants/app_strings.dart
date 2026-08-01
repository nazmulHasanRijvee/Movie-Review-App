import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppStrings {

  const AppStrings._();

  static const String appName = 'Movie Review App';

  // You should store your TMDB authorization key here.
  // For security, this is typically loaded at runtime via environment variables natively.
  static final apiKey = dotenv.env['API_TOKEN'] ?? '';
  static final String authorizationToken =
      'Bearer $apiKey';

  // Onboarding screen
  static const onboardingText = '"Track films you\'ve watched. Save those you want to see."';

  // login screen
  static const loginText = 'Login';
  static const signInText = 'Please sign in to continue';

}