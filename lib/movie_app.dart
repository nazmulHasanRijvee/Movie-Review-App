import 'package:cinephiler/src/presentation/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/utils.dart';

import 'src/presentation/core/app_bindings/app_bindings.dart';
import 'src/presentation/core/routes/app_pages.dart';
import 'src/presentation/core/routes/app_routes.dart';

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Movie Review',
      theme: context.theme,
      darkTheme: context.darkTheme,
      initialRoute: AppRoutes.splash,
      initialBinding: AppBindings(),
      getPages: AppPages.routes,
    );
  }
}
