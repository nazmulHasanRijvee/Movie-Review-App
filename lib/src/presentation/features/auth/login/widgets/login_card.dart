import 'package:cinephiler/src/presentation/core/theme/theme.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/app_strings.dart';
import 'login_button.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      color: Colors.white38,
      child: Container(
        isAntiAlias: true,
        height: 300,
        width: double.maxFinite,
        child: Column(
          children: [
            const SizedBox(height: 50),
            Text(
              AppStrings.loginText,
              style: context.textStyle.bodyLarge,
            ),

            /// Telling the user to Sign in to continue
            const SizedBox(height: 10),
            Text(
              AppStrings.signInText,
              style: context.textStyle.bodyLarge.copyWith(
                fontWeight: .w500,
                color: Colors.white.withAlpha(200),
              ),
            ),
            const SizedBox(height: 50),

            /// OutLinedButton for starting the OAuth process
            const LoginButton(),
          ],
        ),
      ),
    );
  }
}
