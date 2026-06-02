import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:of_28_movie_review_app/data/models/movie_details_model.dart';
import 'package:of_28_movie_review_app/data/models/movie_model.dart';
import 'package:of_28_movie_review_app/data/utils/urls.dart';
import 'package:of_28_movie_review_app/presentation/movie_details/controllers/movie_details_controller.dart';

import '../../../core/app_colors.dart';

class MovieDetailsScreen extends StatefulWidget {

  const MovieDetailsScreen({super.key});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {

  final MovieModel movieModel = Get.arguments as MovieModel;
  final controller = Get.find<MovieDetailsController>();

  @override
  void initState() {
    super.initState();
    fetchMovieDetails();
  }

  Future<void> fetchMovieDetails() async {

    final isSuccess = await controller.fetchMovieDetails(movieModel.id);

    if(!isSuccess && mounted) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(controller.errorMessage ?? "Failed to Load API"
            ),
            backgroundColor: Colors.redAccent,
        )
      );

    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: AppColors.primary,

      appBar: AppBar(
        title: Text(movieModel.title, style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Obx(
           () {

             if(controller.isLoading.value) {
               return Column(
               children: [
                 const SizedBox(height: 330),
                 Center(child: CircularProgressIndicator(backgroundColor: Colors.yellowAccent,)),
               ],
             );
             }

             final MovieDetailsModel? movie = controller.movie;

             if(movie == null) return Center(child: Text('Failed To Load'));

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      // Background Banner Image
                      Container(
                        height: 250,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: NetworkImage(
                              '${Urls.imageBaseUrl}${movie.backdropPath}',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      // Dark Overlay
                      Container(
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.8),
                            ],
                          ),
                        ),
                      ),

                      // Content
                      Positioned(
                        bottom: 16,
                        left: 16,
                        right: 16,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // Poster Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                '${Urls.imageBaseUrl}${movie.posterPath}',
                                height: 140,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),

                            const SizedBox(width: 16),

                            // Movie Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    movie.title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  Text(
                                    movie.tagLine,
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.8),
                                      fontSize: 14,
                                    ),
                                  ),

                                  const SizedBox(height: 12),

                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_month,
                                        color: Colors.white70,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          movie.releaseDate,
                                          style: TextStyle(color: Colors.white70),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Icon(
                                        Icons.access_time_rounded,
                                        color: Colors.white70,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          _formatTime(movie.duration),
                                          style: TextStyle(color: Colors.white70),
                                        ),
                                      ),

                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Row(

                    mainAxisAlignment: .spaceBetween,

                    children: [

                      SizedBox(
                        height: 30,
                        width: 114,
                        child: ElevatedButton.icon(

                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                              backgroundColor: Colors.grey.shade800,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(18)
                              )
                            ),
                            onPressed: () {},
                            icon: Icon(
                              Icons.play_circle_outline_rounded,
                              color: Colors.redAccent,
                              size: 14,
                            ),
                            label: Text('Watch Trailer', style: TextStyle(fontSize: 12),),
                        ),
                      ),

                      //const SizedBox(width: 10),

                      SizedBox(
                        height: 30,
                        width: 114,
                        child: ElevatedButton.icon(

                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 14),
                              backgroundColor: Colors.grey.shade800,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(18)
                              )
                          ),
                          onPressed: () {},
                          icon: Icon(
                              Icons.bookmark_add_outlined,
                              size: 16,
                          ),
                          label: Text('Wishlist', style: TextStyle(fontSize: 12),),
                        ),
                      ),

                      //const SizedBox(width: 10),

                      SizedBox(
                        height: 30,
                        width: 114,
                        child: ElevatedButton.icon(

                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 14),
                              backgroundColor: Color(0xFFFFCA45),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(18)
                              )
                          ),
                          onPressed: () {},
                          icon: Icon(
                            Icons.add_box,
                            size: 16,
                          ),
                          label: Text('Log', style: TextStyle(fontSize: 12),),
                        ),
                      )

                    ],
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'Overview:',
                      style: TextStyle(
                        color: Color(0xFFFFCA45),
                        fontWeight: .w600,
                      )
                  ),

                  const SizedBox(height: 5),

                  Text(movie.overview, style: TextStyle(color: Colors.white, fontWeight: .w500)),
                  const SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      text: 'Release Date: ',
                      style: TextStyle(
                          color: Color(0xFFFFCA45),
                          fontWeight: .w600,
                      ),

                      children: [
                        TextSpan(
                          text: movie.releaseDate,
                          style: TextStyle(color: Colors.white)
                        )
                      ]

                    ),
                    // 'Release Date: ${movie.releaseDate}',
                    // style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Rating: ${movie.voteAverage}',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 16),

                ],
              ),
            );
          }
        ),
      ),
    );
  }

  String _formatTime(int duration) {

    final int hours = duration ~/ 60;
    final int minutes = duration.remainder(60);

    return '${hours}h ${minutes}m';

  }

}
