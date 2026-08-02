import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:of_28_movie_review_app/app/routes/app_routes.dart';
import 'package:of_28_movie_review_app/features/shared/data/model/movie_model.dart';

import '../../../../app/controllers/auth_controller.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/asset_paths.dart';
import '../../../shared/data/model/user_model.dart';
import '../controllers/home_controller.dart';
import '../widgets/movie_card.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final controller = Get.find<HomeController>();
  final  UserModel? user = Get.find<AuthController>().userModel;

  @override
  void initState() {

    super.initState();
    _fetchMovies();
  }

  Future<void> _fetchMovies () async {

    Future.wait([
      controller.fetchMovies('new'),
      controller.fetchMovies('upcoming'),
      controller.fetchMovies('trending')
    ]);

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
                fit: .contain
            ),
            const SizedBox(width: 5),
            Text(
              'CINEPLEX, Hi ${user?.name ?? 'Stranger'}',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
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

      body: Obx(
         () {

           if (controller.isLoading.value) {
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
        }
      ),
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
                color: Colors.white
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
                  Get.toNamed(
                      AppRoutes.movieDetails,
                      arguments: data[index]
                  );
                },
              );
            },
          ),
        ),

      ],

    );

  }

}