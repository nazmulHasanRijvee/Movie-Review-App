import 'package:app_links/app_links.dart';
import 'package:get/get.dart';
import 'package:of_28_movie_review_app/features/movie_details/data/repositories/movie_repository.dart';

import '../../core/services/api_service.dart';
import '../../core/services/deep_link_services.dart';


class AppBindings implements Bindings {

  @override
  void dependencies() {

    Get.put(ApiService(), permanent: true);

    final AppLinks appLinks = AppLinks();

    Get.put(DeepLinkServices(appLinks: appLinks), permanent: true);
    Get.put(MovieRepository(), permanent: true);

  }

}