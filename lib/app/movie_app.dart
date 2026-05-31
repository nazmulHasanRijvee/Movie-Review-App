import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:of_28_movie_review_app/app/bindings/app_bindings.dart';

import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Movie Review',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: AppRoutes.splash,
      initialBinding: AppBindings(),
      getPages: AppPages.routes,
    );
  }
}