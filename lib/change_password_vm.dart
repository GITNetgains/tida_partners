import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_partners/change_password_model.dart';
import 'package:tida_partners/network/ApiProvider.dart';
import 'package:tida_partners/utilss/SharedPref.dart';

class ChangePasswordVM extends GetxController{
  TextEditingController newpassword = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  void showSnackbar(msg) {
    Get.snackbar("Please provide $msg", "$msg is required.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
  }

  Future<void> changepass() async {
    if (newpassword.text.trim().isEmpty) {
      showSnackbar("New Password");
      return;
    } else if (confirmpassword.text.trim().isEmpty) {
      showSnackbar("Confirm Password");
      return;
    } else if(isPasswordCompliant(newpassword.text.trim().toString()) ==
        false){
     Get.snackbar("Please provide valid Password",
          "Password should have minimum of 1 special Character, 1 Uppercase letter, 1 lowercase letter, 1 digit and minimum length of 8 characters.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    else {
      if (confirmpassword.text.trim() != newpassword.text.trim()) {
        Get.snackbar("Not Matching","Confirm Password not matching newpassword",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
        return;
      } else {
        
        Map<String,String> data = {
          "token": await Preferences.getToken(),
          "userid":await Preferences.getUserId(),
          "new_password": newpassword.text.trim()
        };
        print(data);
        await ApiProvider.changepass(data).then((res) async {
        ChangePasswordModel? resp = ChangePasswordModelFromJson(res);print("-------------");
                Get.back(result: true);
          if (resp!.status == false) {
            Get.snackbar("Server Response", "${resp.message}",
                backgroundColor: Colors.red,
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM);
          } else {
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
  }
}
bool? isPasswordCompliant(String password, [int minLength = 8]) {
  if (password == null || password.isEmpty) {
    return false;
  }

  bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
  bool hasDigits = password.contains(RegExp(r'[0-9]'));
  bool hasLowercase = password.contains(RegExp(r'[a-z]'));
  bool hasSpecialCharacters =
      password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  bool hasMinLength = password.length >= minLength;

  return hasDigits &
      hasUppercase &
      hasLowercase &
      hasSpecialCharacters &
      hasMinLength;
}