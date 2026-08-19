import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../core/services/api_service.dart';
import '../../../../core/utils/urls.dart';

class OnboardingController extends GetxController {

  final ApiService apiService;

  OnboardingController({required this.apiService});

  final RxBool _isLoading = false.obs;
  String? _errorMessage;

  bool get isLoading => _isLoading.value;
  String? get errorMessage => _errorMessage;


  Future<String?> getRequestToken() async {

    _isLoading.value = true;
    String? requestToken;

    final ApiResponse apiResponse = await apiService.getRequest(url: Urls.requestToken);

    if(apiResponse.isSuccess && apiResponse.body['success']) {

      requestToken = apiResponse.body['request_token'];

      _errorMessage = null;

    } else {

      _errorMessage = apiResponse.errorMessage ?? 'Showing error from controller';

    }

    _isLoading.value = false;

    return requestToken;

  }

}