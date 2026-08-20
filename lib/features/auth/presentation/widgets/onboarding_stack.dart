import 'package:flutter/material.dart';
import 'package:of_28_movie_review_app/features/auth/presentation/widgets/movie_app_logo.dart';

import '../../../../core/utils/asset_paths.dart';

class OnboardingStack extends StatelessWidget {
  const OnboardingStack({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 500,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(AssetPaths.onboardingBanner, fit: BoxFit.cover),
          Positioned(
            top: 300,
            left: MediaQuery.sizeOf(context).width / 3.8,
            child: MovieAppLogo(width: 180, height: 180),
          ),
        ],
      ),
    );
  }

  /// Build background banner for the stack
  // Widget buildBackgroundBanner() {
  //   return
  // }
}
