import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'movie_app.dart';
import 'src/core/logger/app_logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();
  Get.put<SharedPreferences>(sharedPreferences, permanent: true);

  runZonedGuarded(
    () {
      runApp(const MovieApp());
    },
    (e, stackTrace) {
      AppLogger.error('Uncaught Exception', error: e, stackTrace: stackTrace);
    },
  );
}
