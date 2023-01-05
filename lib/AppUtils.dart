
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppUtills{

  static showSnackBar(String title,String msg,{bool isError= false}){
    Get.snackbar(
      title,
     msg,
      icon: Icon(isError?Icons.error:Icons.done, color: Colors.white),
      titleText: Text(title, style: TextStyle(color: Colors.white),),
      messageText: Text(msg, style: TextStyle(color: Colors.white),),
      snackPosition: SnackPosition.BOTTOM,
      shouldIconPulse: true,
      backgroundColor: isError?Colors.red:Colors.green,
    );

  }

}