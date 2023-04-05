
import 'package:get/get.dart';

import '../login_screen.dart';
import '../network/ApiProvider.dart';
class ProfileController extends GetxController {
  RxBool isLoading = false.obs;

  Future deleteProfile() async {
    isLoading(true);
    bool result = await ApiProvider().deleteProfile();
    isLoading(false);
    if (result) {
      Get.offAll(LoginScreen());
    }
  }
}