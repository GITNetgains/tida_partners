import 'dart:io';

import 'package:get/get.dart';
import 'package:tida_partners/AppUtils.dart';
import 'package:tida_partners/home_screen.dart';
import 'package:tida_partners/network/ApiProvider.dart';
import 'package:tida_partners/utilss/SharedPref.dart';

class LoginController extends GetxController {
  RxString userEmail = "".obs;
  RxString userPassword = "".obs;
  RxBool loading = false.obs;

  Future<void> loginUser() async {
    if (userEmail.isEmpty) {
      AppUtills.showSnackBar("Required", "Please enter a valid email",
          isError: true);
    } else if (userPassword.value.isEmpty) {
      AppUtills.showSnackBar("Required", "Please enter a valid password",
          isError: true);
    } else {
      loading(true);
      Map<String, String> data = {
        "email": userEmail.value,
        "password": userPassword.value,
        "device_type": Platform.operatingSystem,
        "device_token": "TO-BE-IMPLEMENTED",
      };
      bool loggedIn = await ApiProvider().loginUser(data);
      loading(false);
      if (loggedIn) {
        Get.to(() => HomeScreen());
      }
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    checkLoggedIn();
    super.onInit();
  }

  void checkLoggedIn() async {
    bool data = await Preferences.getLoggedIn();
    if (data) {
      Get.offAll(() => HomeScreen());
    }
  }
}
