import 'package:material_ui/material_ui.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:of_28_movie_review_app/features/auth/presentation/widgets/button_loading_indicator.dart';

import '../../../../core/extensions/theme_extension.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;

  const OnboardingElevatedButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final OnboardingController controller = Get.find<OnboardingController>();

    return SizedBox(
      width: 260,
      height: 50,
      child: ElevatedButton(
        // style: ElevatedButton.styleFrom(
        //     elevation: 5,
        //     backgroundColor: AppColors.accent,
        //     shape: RoundedRectangleBorder(
        //         borderRadius: .circular(12)
        //     )
        // ),
        onPressed: onPressed,
        child: Obx(() {
          if (controller.isLoading) return const ButtonLoadingIndicator();

          return Text('Get Started', style: context.theme.textTheme.bodyLarge);
        }),
      ),
    );
  }
}
