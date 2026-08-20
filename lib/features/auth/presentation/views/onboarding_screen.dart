import 'package:material_ui/material_ui.dart';
import 'package:get/get.dart';
import 'package:of_28_movie_review_app/features/auth/presentation/widgets/onboarding_elevated_button.dart';
import 'package:of_28_movie_review_app/features/auth/presentation/widgets/onboarding_stack.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../core/constants/app_strings.dart';
import '../controllers/onboarding_controller.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _controller = Get.find<OnboardingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          OnboardingStack(),
          const SizedBox(height: 10),
          buildOnboardingText(context),
          const SizedBox(height: 90),
          OnboardingElevatedButton(onPressed: getToken),
        ],
      ),
    );
  }

  /// Build onboarding text
  Widget buildOnboardingText(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Text(
        AppStrings.onboardingText,
        style: context.theme.textTheme.bodyLarge,
        textAlign: TextAlign.center,
      ),
    );
  }

  /// Get a new request_token from TMDB when button clicked
  Future<void> getToken() async {
    final requestToken = await _controller.getRequestToken();

    if (requestToken != null) {
      Get.toNamed(AppRoutes.login, arguments: requestToken);
    }

    // Get.toNamed(AppRoutes.login);
  }
}
