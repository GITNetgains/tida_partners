import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tida_partners/AppUtils.dart';
import 'package:tida_partners/home_screen.dart';
import 'package:tida_partners/network/ApiProvider.dart';
import 'package:tida_partners/utilss/SharedPref.dart';

class LoginController extends GetxController {
  RxString userEmail = "".obs;
  RxString userPassword = "".obs;
  RxBool loading = false.obs;

  GlobalKey<FormState> loginformkey = GlobalKey();
  Future<void> loginUser() async {
    if (userEmail.isEmpty) {
      AppUtills.showSnackBar("Required", "Please enter a valid email",
          isError: true);
    }  
    if (userPassword.value.isEmpty) {
      AppUtills.showSnackBar("Required", "Please enter a valid password",
          isError: true);
    } 

    String token = await FirebaseMessaging.instance.getToken() ?? "";

    if(userPassword.value.isNotEmpty && userEmail.value.isNotEmpty) {
      loading(true);
      Map<String, String> data = {
        "email": userEmail.value,
        "password": userPassword.value,
        "device_type": Platform.operatingSystem,
        "fcm_token": token,
        "device_token": "TO-BE-IMPLEMENTED",
      };
      bool loggedIn = await ApiProvider().loginUser(data);
      print(data);
      loading(false);
      if (loggedIn) {
        Get.offAll(() => HomeScreen());
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
