import 'package:get/get.dart';
import 'package:of_28_movie_review_app/app/routes/app_routes.dart';
import 'package:of_28_movie_review_app/presentation/home/bindings/home_bindings.dart';
import 'package:of_28_movie_review_app/presentation/home/views/home_screen.dart';
import 'package:of_28_movie_review_app/presentation/movie_details/bindings/movie_details_bindings.dart';
import 'package:of_28_movie_review_app/presentation/movie_details/views/movie_details_screen.dart';
import 'package:of_28_movie_review_app/presentation/search_movie/bindings/search_bindings.dart';
import 'package:of_28_movie_review_app/presentation/search_movie/views/search_screen.dart';
import 'package:of_28_movie_review_app/presentation/splash/views/splash_screen.dart';

class AppPages {

  static final List<GetPage>routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen()
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