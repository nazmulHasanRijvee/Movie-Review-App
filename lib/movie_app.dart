import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';


import 'src/presentation/core/app_bindings/app_bindings.dart';
import 'src/presentation/core/routes/app_pages.dart';
import 'src/presentation/core/routes/app_routes.dart';
import 'src/presentation/core/themes/app_theme.dart';

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Movie Review',
      theme: AppTheme.theme,
      initialRoute: AppRoutes.splash,
      initialBinding: AppBindings(),
      getPages: AppPages.routes,
    );
  }
}
