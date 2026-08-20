import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/urls.dart';

class UrlLauncherService extends GetxService {
  Future<void> launchAuthUrl(String requestToken) async {
    String redirectTo = 'redirect_to=cinephiler://auth';

    final authUri = Uri.parse('${Urls.oAuthLink}/$requestToken?$redirectTo');

    if (await canLaunchUrl(authUri)) {
      await launchUrl(authUri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $authUri');
    }
  }
}
