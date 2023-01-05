import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_partners/controllers/ForgotController.dart';

import 'AppColors.dart';
import 'controllers/LoginController.dart';
import 'utilss/size_config.dart';
import 'utilss/theme.dart';

class ForgotPassword extends StatelessWidget {
    ForgotPassword({Key? key}) : super(key: key);

  final _controller = Get.put(ForgotController());
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(
        BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width),
        MediaQuery.of(context).orientation);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: setHeadlineMedium("Forgot password"),
      ),
      bottomNavigationBar: Image.asset("assets/footer.png"),
      backgroundColor: Colors.white,
      body: ListView(
        children: [Container(
          margin: EdgeInsets.only(top: 100),
          padding:   EdgeInsets.all(LARGE_PADDING),
          child: Column(

            children: [
              Center(child: Image.asset("assets/app_icon.jpg", width: 150,height: 150,)),

              getVerticalSpace(),
              getVerticalSpace(),
              setMediumLabel("Please enter your registered email and click reset. If we found account associated with entered email, we will send instructions to reset your password. ", color: Colors.black),
             getVerticalSpace(),
             getVerticalSpace(),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: NORMAL_PADDING),
                    child: Image.asset(
                      "assets/user.png",
                      width: 18,
                      height: 18,
                    ),
                  ),
                  setMediumLabel("Email"),
                ],
              ),
              getVerticalSpace(),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey.withOpacity(0.2)),
                child:   TextField(
                  onChanged: (_){
                    _controller.userEmail(_);

                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: LARGE_PADDING),
                      hintText: "admin@hotmail.com",
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
              ),
              getVerticalSpace(),

              getVerticalSpace(),

              getVerticalSpace(),
              Obx(() =>_controller.loading.value?Center(child: CircularProgressIndicator(),): Container(
                  width: double.infinity,
                  child: getSecondaryButton("Reset", () {
                    _controller.forgotPass();

                  }))),







            ],
          ),
        )],

      ),
    );
  }
}
