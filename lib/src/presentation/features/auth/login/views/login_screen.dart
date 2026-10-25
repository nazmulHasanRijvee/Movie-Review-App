import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/login_background.dart';
import '../widgets/login_card.dart';
import '../widgets/movie_app_logo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    // final token = Get.arguments as String;
    // debugPrint(token);
  }

  @override
  Widget build(BuildContext context) {
    return LoginBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Center(
            child: Column(
              mainAxisAlignment: .end,
              children: [
                const SizedBox(height: 40),
                buildTopRow(context),
                const Spacer(),
                const LoginCard(),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// A Row at the top to show the app logo and name
  Row buildTopRow(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        MovieAppLogo(width: 65, height: 65),
        Text('CINEPHILER', style: context.theme.textTheme.bodyLarge),
      ],
    );
  }
}
