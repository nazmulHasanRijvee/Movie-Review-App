import 'package:flutter/material.dart';

import '../../../data/models/movie_model.dart';
import '../../../data/utils/urls.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.movie, required this.onTap});
  final MovieModel movie;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: [
            Container(
              height: 200,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage( /// Replace with CachedNetwork image
                    '${Urls.imageBaseUrl}${movie.posterPath}',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 120,
              child: Text(
                movie.title,
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}