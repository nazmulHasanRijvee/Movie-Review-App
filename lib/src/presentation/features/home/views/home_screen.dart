import 'package:cinephiler/src/data/repositories/auth_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cinephiler/src/presentation/core/routes/app_routes.dart';
import 'package:cinephiler/src/data/models/movie_model.dart';
import 'package:cinephiler/src/core/constants/app_colors.dart';
import 'package:cinephiler/src/core/utils/asset_paths.dart';
import 'package:cinephiler/src/data/models/user_model.dart';
import 'package:cinephiler/src/presentation/features/home/controllers/home_controller.dart';
import 'package:cinephiler/src/presentation/features/home/widgets/movie_card.dart';

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
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          mainAxisSize: .min,
          children: [
            Image.asset(
              AssetPaths.movieAppLogo,
              height: 50,
              width: 50,
              fit: .contain,
            ),
            const SizedBox(width: 5),
            Text(
              'CINEPLEX, Hi ${user?.name ?? 'Stranger'}',
              style: TextStyle(
                // Add text theme
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.primary,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(AppRoutes.searchMovie);
            },
            icon: Icon(Icons.search, color: Colors.white),
          ),
          IconButton(
            onPressed: () async {
              await controller.logOut();
            },
            icon: Icon(Icons.exit_to_app_rounded, color: Colors.white),
          ),
        ],
      ),

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
            itemBuilder: (context, index) {
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
