import 'dart:convert';

import 'package:cinephiler/src/data/services/cache/cache_service.dart';
import 'package:get/get.dart';


import '../models/user_model.dart';

class AuthRepositoryImpl extends GetxService {

  AuthRepositoryImpl({required this.cacheService}) {
    getUserData();
  }

  final CacheService cacheService;
  UserModel? _userModel;

  UserModel? get user => _userModel;
  

  Future<void> saveUserData(UserModel model) async {
    await cacheService.save<String>(CacheKey.user, jsonEncode(model.toJson()));
    _userModel = model;
  }

  Future<void> getUserData() async {
    final userData = cacheService.get<String>(CacheKey.user);

    if (userData != null) {
      _userModel = UserModel.fromJson(jsonDecode(userData));
    }
  }

  Future<void> clearUserData() async {
    await cacheService.remove([CacheKey.user]);
    _userModel = null;
  }
}
