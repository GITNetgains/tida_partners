import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/LoginController.dart';
import 'forgot_password.dart';
import 'signup.dart';
import 'utilss/size_config.dart';
import 'utilss/theme.dart';

class LoginScreen extends StatelessWidget {
    LoginScreen({Key? key}) : super(key: key);
  final _controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(
        BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width),
        MediaQuery.of(context).orientation);
    return Scaffold(
      bottomNavigationBar: Image.asset("assets/footer.png"),
      backgroundColor: Colors.white,
      body: ListView(
        children: [Container(
          margin: EdgeInsets.only(top: 100),
          padding: const EdgeInsets.all(LARGE_PADDING),
          child: Form(
            key: _controller.loginformkey,
            child: Column(
          
              children: [
                Center(child: Image.asset("assets/app_icon.jpg", width: 150,height: 150,)),
          
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
                    setMediumLabel("User"),
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
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: NORMAL_PADDING),
                      child: Image.asset(
                        "assets/padlock.png",
                        width: 18,
                        height: 18,
                      ),
                    ),
                    setMediumLabel("Password"),
                  ],
                ),
                getVerticalSpace(),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.grey.withOpacity(0.2)), child:   TextField(
                  onChanged: (_){
                    _controller.userPassword(_);
                  },
                  obscureText: true,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: LARGE_PADDING),
                      hintText: "**********",
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
                ),
                getVerticalSpace(),
                getVerticalSpace(),
                getVerticalSpace(),
                Obx(() =>_controller.loading.value?Center(child: CircularProgressIndicator(),): Container(
                    width: double.infinity,
                    child: getSecondaryButton("Sign In", () {
                      _controller.loginUser();
          
                    }))),
                getVerticalSpace(),
                getVerticalSpace(),
                InkWell(
                    onTap: (){
                      Get.off(()=>ForgotPassword());
                    },
                    child: Center(child: setMediumLabel("Forgot Password?"))),
                getVerticalSpace(),
                getVerticalSpace(),
                   /*     getVerticalSpace(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      decoration: BoxDecoration(
                          border:
                          Border(bottom: BorderSide(color: Colors.black))),
                    ),
                    getHorizontalSpace(),
                    getHorizontalSpace(),
                    setMediumLabel("OR"),
                    getHorizontalSpace(),
                    getHorizontalSpace(),
                    Container(
                      width: 80,
                      decoration: BoxDecoration(
                          border:
                          Border(bottom: BorderSide(color: Colors.black))),
                    ),
                  ],
                ),
                getVerticalSpace(),
                getVerticalSpace(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/apple.png",
                      width: 24,
                      height: 24,
                    ),
                    getHorizontalSpace(), Image.asset(
                      "assets/google.png",
                      width: 24,
                      height: 24,
                    ),
                    getHorizontalSpace(),
                    Image.asset(
                      "assets/twitter.png",
                      width: 30,
                      height: 30,
                    )
                  ],
                ),
                getVerticalSpace(),
                getVerticalSpace(),*/
                getVerticalSpace(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    setMediumLabel("Don't have an account?"),
                    getHorizontalSpace(),
                    InkWell(
                        onTap: (){
                          Get.to(()=>SignupScreen());
                        },
                        child: setMediumLabel("REGISTER", color: Colors.red,decoration: TextDecoration.underline)),
                  ],
                ),
          
          
              ],
            ),
          ),
        )],

      ),
    );
  }
}
