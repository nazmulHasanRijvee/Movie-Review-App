import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/asset_paths.dart';
import '../controllers/onboarding_controller.dart';


class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  final OnboardingController _controller = Get.find<OnboardingController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: AppColors.primary,
      body: Column(
        children: [
          Stack(
            clipBehavior: .none,
            children: [
              SizedBox(width: double.infinity, height: 500),
              Positioned.fill(child: buildBackgroundBanner()),
              Positioned(
                top: 300,
                left: MediaQuery.sizeOf(context).width / 3.8,
                child: buildLogo()
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 250,
            child: Text(
              AppStrings.onboardingText,
              style: context.theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 80),
          SizedBox(
            width: 260,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 6,
                backgroundColor: AppColors.accent,
                shape: RoundedRectangleBorder(
                  borderRadius: .circular(12)
                )
              ),
              onPressed: getToken,
              child: Obx(() {

                  if(_controller.isLoading) return buildLoadingIndicator();

                  return Text('Get Started', style: context.theme.textTheme.bodyLarge);
                }
              )
            ),
          )
        ],
      ),
    );
  }

  SizedBox buildLoadingIndicator() {
    return SizedBox(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(
          strokeWidth: 4,
        )
    );
  }

  /// Build movie app logo
  Widget buildLogo() {
    return Image.asset(
      height: 180,
      width: 180,
      AssetPaths.movieAppLogo,
      fit: .cover,
    );
  }

  /// Build background banner
  Widget buildBackgroundBanner() {
    return Image.asset(
      width: double.infinity,
      AssetPaths.onboardingBanner,
      fit: .cover,
    );
  }


  Future<void> getToken() async {

    final requestToken = await _controller.getRequestToken();

    if(requestToken != null) {

      Get.toNamed(AppRoutes.login, arguments: requestToken);

    }

  }

}