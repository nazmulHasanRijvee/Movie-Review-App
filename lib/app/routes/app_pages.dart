import 'package:get/get.dart';
import 'package:of_28_movie_review_app/app/routes/app_routes.dart';
import 'package:of_28_movie_review_app/presentation/home/bindings/home_bindings.dart';
import 'package:of_28_movie_review_app/presentation/home/views/home_screen.dart';
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
  ];

}