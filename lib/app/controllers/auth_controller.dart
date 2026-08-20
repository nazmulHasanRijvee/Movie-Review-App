import 'dart:convert';

import 'package:material_ui/material_ui.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/shared/data/model/user_model.dart';

class AuthController extends GetxService {
  // Dependency Injection
  final SharedPreferences sharedPreferences;

  AuthController({required this.sharedPreferences});

  static const String _accessSessionIdKey = 'session';
  static const String _userModelKey = 'user';

  String? _accessSessionId;
  UserModel? _userModel;

  String? get accessSessionId => _accessSessionId;
  UserModel? get userModel => _userModel;

  Future<void> saveUserData(UserModel model, String sessionId) async {
    await sharedPreferences.setString(_accessSessionIdKey, sessionId);
    await sharedPreferences.setString(
      _userModelKey,
      jsonEncode(model.toJson()),
    );
    _accessSessionId = sessionId;
    _userModel = model;
  }

  Future<void> getUserData() async {
    String? sessionId = sharedPreferences.getString(_accessSessionIdKey);
    if (sessionId != null) {
      String? userData = sharedPreferences.getString(_userModelKey);
      _userModel = UserModel.fromJson(jsonDecode(userData!));
      _accessSessionId = sessionId;
    }
  }

  Future<void> updateUserData(UserModel model) async {
    await sharedPreferences.setString(
      _userModelKey,
      jsonEncode(model.toJson()),
    );
    _userModel = model;
  }

  Future<bool> isUserLoggedIn() async {
    String? sessionId = sharedPreferences.getString(_accessSessionIdKey);
    debugPrint('SessionId: $sessionId');
    String? userData = sharedPreferences.getString(_userModelKey);
    if (sessionId != null) _accessSessionId = sessionId;
    if (userData != null) _userModel = UserModel.fromJson(jsonDecode(userData));
    return sessionId != null;
  }

  Future<void> clearUserData() async {
    await sharedPreferences.remove(_accessSessionIdKey);
    await sharedPreferences.remove(_userModelKey);
    // or use .clear() to remove all keys
    _accessSessionId = null;
    _userModel = null;
  }
}
