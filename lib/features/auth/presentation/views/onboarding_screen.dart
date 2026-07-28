import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
// import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/deep_link_services.dart';
import '../../../../core/utils/asset_paths.dart';



class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    Get.find<DeepLinkServices>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Stack(
          children: [
            Image.asset(
              AssetPaths.onboardingBanner,
              fit: .cover,
            ),
            buildLogo(),
          ],
        ),
      ),
    );
  }

  /// Build movie app logo
  Container buildLogo() {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        shape: .circle,
      ),
      child: Image.asset(
        AssetPaths.movieAppLogo,
        height: 60,
        width: 60,
      ),
    );
  }
}