import 'dart:io';

import 'package:get/get.dart';
import 'package:tida_partners/AppUtils.dart';
import 'package:tida_partners/home_screen.dart';
import 'package:tida_partners/login_screen.dart';
import 'package:tida_partners/network/ApiProvider.dart';

class SignUpController extends GetxController {
  RxString userName = "".obs;
  RxString userEmail = "".obs;
  RxString userPhone = "".obs;
  RxString userPassword = "".obs;
  RxString userConfirmPass = "".obs;
  RxBool loading = false.obs;

  Future<void> signUpUser() async {
    if (userName.isEmpty) {
      AppUtills.showSnackBar("Required", "Please enter a valid name",
          isError: true);
    } else if (userEmail.value.isEmpty) {
      AppUtills.showSnackBar("Required", "Please enter a valid email",
          isError: true);
    }else if (userPhone.value.isEmpty) {
      AppUtills.showSnackBar("Required", "Please enter a valid number",
          isError: true);
    }else if (userPassword.value.isEmpty) {
      AppUtills.showSnackBar("Required", "Please enter a valid password",
          isError: true);
    }else if (userConfirmPass.value.isEmpty) {
      AppUtills.showSnackBar("Required", "Please re-enter password",
          isError: true);
    }else if (userConfirmPass.value != userPassword.value) {
      AppUtills.showSnackBar("Required", "Please re-enter correct password",
          isError: true);
    } else {
      loading(true);
      Map<String, String> data = {
        "name": userName.value,
        "email": userEmail.value,
        "password": userPassword.value,
        "phone": userPhone.value,
        "device_type": Platform.operatingSystem,
        "type": "2",
        "device_token": "TO-BE-IMPLEMENTED",
      };
      bool loggedIn = await ApiProvider().signUp(data);
      loading(false);
      if (loggedIn) {
        Get.offAll(() =>   LoginScreen());
      }
    }
  }
}
