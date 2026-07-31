import 'package:get/get.dart';
import 'package:of_28_movie_review_app/app/routes/app_routes.dart';
import 'package:of_28_movie_review_app/features/auth/presentation/views/login_screen.dart';

import '../../features/auth/presentation/bindings/onboarding_bindings.dart';
import '../../features/auth/presentation/views/onboarding_screen.dart';
import '../../features/home/presentation/bindings/home_bindings.dart';
import '../../features/home/presentation/views/home_screen.dart';
import '../../features/movie_details/presentation/bindings/movie_details_bindings.dart';
import '../../features/movie_details/presentation/views/movie_details_screen.dart';
import '../../features/search_movie/presentation/bindings/search_bindings.dart';
import '../../features/search_movie/presentation/views/search_screen.dart';
import '../../features/splash/views/splash_screen.dart';

class AppPages {

  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen()
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnBoardingScreen(),
      binding: OnboardingBindings(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
    ),
    GetPage(
        name: AppRoutes.home,
        page: () => const HomeScreen(),
        binding: HomeBindings()
    ),
    GetPage(
        name: AppRoutes.movieDetails,
        page: () => const MovieDetailsScreen(),
        binding: MovieDetailsBindings()
    ),
    GetPage(
        name: AppRoutes.searchMovie,
        page: () => const SearchScreen(),
        binding: SearchBindings()
    )
  ];

}