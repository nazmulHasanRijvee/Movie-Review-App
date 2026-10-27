import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../data/models/movie_model.dart';
import '../../../../data/models/user_model.dart';
import '../../../../data/repositories/auth_repository_impl.dart';
import '../../../core/routes/app_routes.dart';
import '../controllers/home_controller.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = Get.find<HomeController>();
  UserModel? get user => Get.find<AuthRepositoryImpl>().user;

  @override
  void initState() {
    super.initState();
    controller.fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,

      appBar: HomeAppBar(userName: user?.name),

      body: Obx(() {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),

              _buildList('New Releases', controller.newlyReleased),

              _buildList('Trending Movies', controller.trendingMovies),

              _buildList('Upcoming Movies', controller.upcoming),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildList(String title, List<MovieModel> data) {
    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .start,

      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),

          child: Text(
            title,

            style: TextStyle(
              fontSize: 18,
              fontWeight: .bold,
              color: Colors.white,
            ),
          ),
        ),

        const SizedBox(height: 5),

        SizedBox(
          height: 270,
          child: ListView.builder(
            padding: .zero,
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return MovieCard(
                movie: data[index],

                onTap: () {
                  Get.toNamed(AppRoutes.movieDetails, arguments: data[index]);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
