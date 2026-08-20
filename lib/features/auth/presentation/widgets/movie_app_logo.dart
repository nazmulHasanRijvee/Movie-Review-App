import 'package:flutter/material.dart';

import '../../../../core/utils/asset_paths.dart';

class MovieAppLogo extends StatelessWidget {
  final double width;
  final double height;

  const MovieAppLogo({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      height: height,
      width: width,
      AssetPaths.movieAppLogo,
      fit: BoxFit.cover,
    );
  }
}
