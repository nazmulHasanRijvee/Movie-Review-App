import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:get/get.dart';

class DeepLinkServices extends GetxService {

  final AppLinks appLinks;

  DeepLinkServices({ required this.appLinks});

  Future<Uri?> get initialUri => appLinks.getInitialLink();

  Stream<Uri> get uriStream => appLinks.uriLinkStream;

}