import 'package:app_links/app_links.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:of_28_movie_review_app/core/services/deep_link_services.dart';
import 'package:of_28_movie_review_app/core/services/url_launcher_service.dart';
import 'package:of_28_movie_review_app/features/auth/presentation/controllers/login_controller.dart';

class LoginBindings extends Bindings{

  @override
  void dependencies() {

    Get.put<UrlLauncherService>(UrlLauncherService());

    final appLinks = AppLinks();

    Get.put<DeepLinkServices>(DeepLinkServices(appLinks: appLinks));

    Get.lazyPut(()=> LoginController());

  }

}