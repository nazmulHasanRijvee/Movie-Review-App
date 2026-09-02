import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../core/services/network/api_handler.dart';
import '../../../../core/services/network/rest_client.dart';

class OnboardingController extends GetxController {
  // final ApiService apiService;
  final RestClient restClient;

  OnboardingController({required this.restClient});

  final RxBool _isLoading = false.obs;
  String? _errorMessage;
  String? _requestToken;

  bool get isLoading => _isLoading.value;
  String? get requestToken => _requestToken;
  String? get errorMessage => _errorMessage;

  Future<bool> getRequestToken() async {
    _isLoading.value = true;
    bool isSuccess = false;

    await Api.call(
      action: restClient.getRequestToken(),
      onSuccess: (data) {
        isSuccess = true;
        _errorMessage = null;
        if (data is Map<String, dynamic>) {
          _requestToken = data["request_token"] as String?;
        }
      },
      onError: (error) {
        isSuccess = false;
        _errorMessage = error;
      },
    );

    _isLoading.value = false;

    return isSuccess;
  }
}
