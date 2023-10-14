import 'dart:io';

import 'package:get/get.dart';
import 'package:tida_partners/AppUtils.dart';
import 'package:tida_partners/login_screen.dart';
import 'package:tida_partners/network/ApiProvider.dart';

class ForgotController extends GetxController {
  RxString userEmail = "".obs;
  RxBool loading = false.obs;

  Future<void> forgotPass() async {
    if (userEmail.isEmpty) {
      AppUtills.showSnackBar("Required", "Please enter a valid email",
          isError: true);
    }  else {
      loading(true);
      Map<String, String> data = {
        "email": userEmail.value,
      };
      bool loggedIn = await ApiProvider().forgotPass(data);
      loading(false);
      if (loggedIn) {
        Get.off(() => LoginScreen());
      }
    }
  }
}
