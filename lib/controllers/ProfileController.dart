
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_partners/change_password_model.dart';
import 'package:tida_partners/my_profile_response.dart';
import 'package:tida_partners/utilss/SharedPref.dart';

import '../login_screen.dart';
import '../network/ApiProvider.dart';
class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
 bool? isEditing = false;

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emCtrl = TextEditingController();
  TextEditingController phCtrl = TextEditingController();
  Future deleteProfile() async {
    isLoading(true);
    bool result = await ApiProvider().deleteProfile();
    isLoading(false);
    if (result) {
      Get.offAll(LoginScreen());
    }
  }

  Future<void> saving() async
  {
        Map<String,String> data = {
          "token": await Preferences.getToken(),
          "userid":await Preferences.getUserId(),
          "name": (nameCtrl.text == "" || nameCtrl == null) ? Preferences.getName() : nameCtrl.text  ,
          "status": "1",
          "phone": (phCtrl.text == "" || phCtrl == null) ?  Preferences.getPhone()  : phCtrl.text.trim(),
          "email" : (emCtrl.text == "" || emCtrl == null) ? Preferences.getEmail() : emCtrl.text.trim() 
        };
        print(data);
        await ApiProvider.updateprofile(data).then((res) async {
        ProfileResponse? resp = ProfileResponse.fromJson(jsonDecode(res));
          if (resp!.status == false) {
            Get.snackbar("Server Response", "${resp.message}",
                backgroundColor: Colors.red,
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM);
          } else {
            print(resp.data!.name.toString());
            print(resp.data!.email.toString());
            print(resp.data!.phone.toString());
            Preferences.setName(resp.data!.name.toString());
            Preferences.setEmail(resp.data!.email.toString());
            Preferences.setPhone(resp.data!.phone.toString());
            Get.back(result: true);
            Get.snackbar("Server Response", "${resp.message}",
                backgroundColor: Colors.green,
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM);

          }
        }).onError((error, stackTrace) {
          Get.snackbar("Server Response", error.toString(),
              backgroundColor: Colors.red,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM);
        });
    }
  }