import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeepLinkServices extends GetxService {

  final AppLinks appLinks;

  DeepLinkServices({ required this.appLinks});

  StreamSubscription? _subscription;

  Future<void> initialize() async {

    final initialLink = await appLinks.getInitialLink();

    if (initialLink != null) {
      debugPrint('Initial Link: $initialLink');
      handleDeepLink(initialLink);
    }

    _subscription = appLinks.uriLinkStream.listen(
      handleDeepLink
    );

  }

  Future<void> handleDeepLink(Uri uri) async {
    if (uri.host != 'auth') return;

    final approved =
    uri.queryParameters['approved'];

    final requestToken =
    uri.queryParameters['request_token'];

    if (approved == 'true') {
      debugPrint('Approved: $approved, $requestToken');
    }
  }

  void dispose() {
    _subscription?.cancel();
  }


}