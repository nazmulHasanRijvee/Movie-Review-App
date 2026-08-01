import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../controllers/login_controller.dart';
import 'button_loading_indicator.dart';

class LoginButton extends StatefulWidget{

  const LoginButton({super.key});

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {

  final controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      height: 50,
      child: Obx(
            () => OutlinedButton(
            onPressed: controller.isLoading ? null : onPressed,
            child: controller.isLoading
                ? const ButtonLoadingIndicator()
                : Text(
              AppStrings.loginText,
              style: context.theme.textTheme.bodyLarge,
            )),
      ),
    );
  }

  /// When Button is pressed, launches the Authentication URL for OAuth
  // if succeeds then navigate to the HomeScreen
  Future<void> onPressed() async {

    final requestToken = Get.arguments as String;
    final isSuccess = await controller.startAuthentication(requestToken);

    debugPrint('Running after authentication');

    if(isSuccess) {
      debugPrint('Navigation Happening');
      Get.offAllNamed(AppRoutes.home);
    }

  }

}