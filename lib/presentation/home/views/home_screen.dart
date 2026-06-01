import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:of_28_movie_review_app/app/routes/app_routes.dart';
import 'package:of_28_movie_review_app/presentation/home/controllers/home_controller.dart';

import '../../../core/app_colors.dart';
import '../widgets/movie_card.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final controller = Get.find<HomeController>();

  @override
  void initState() {

    super.initState();
    controller.fetchTrendingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Home Screen',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => SearchScreen()),
              // );
              Get.toNamed(
                AppRoutes.searchMovie
              );
            },
            icon: Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),

      body: Column(
        mainAxisAlignment: .center,
        children: [
          Obx(
            () {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: controller.trendingMovies.length,
                  itemBuilder: (context, index) {
                    return MovieCard(
                      movie: controller.trendingMovies[index],
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => MovieDetails(
                        //       movie: provider.trendingMovies[index],
                        //     ),
                        //   ),
                        //);
                        Get.toNamed(
                          AppRoutes.movieDetails,
                           arguments: controller.trendingMovies[index]
                        );
                      },
                    );
                  },
                ),
              );
            },
          ), /// End of obx
        ],
      ),
    );
  }
}