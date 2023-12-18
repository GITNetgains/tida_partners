import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/SignUpController.dart';
import 'utilss/size_config.dart';
import 'utilss/theme.dart';

class SignupScreen extends StatelessWidget {
    SignupScreen({Key? key}) : super(key: key);
    final _controller= Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(
        BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width),
        MediaQuery.of(context).orientation);
    return Scaffold(
      bottomNavigationBar: Image.asset("assets/footer.png"),
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: setHeadlineMedium("Create an account",),
      ),
      body: Obx(() => _controller.loading.value?Center(child: CircularProgressIndicator(),):SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(LARGE_PADDING),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  setMediumLabel("Name"),
                ],
              ),
              getVerticalSpace(),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey.withOpacity(0.2)),
                child:   TextField(
                  onChanged: (_){
                    _controller.userName(_);

                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: LARGE_PADDING),
                      hintText: "John Doe",
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
              ),
              getVerticalSpace(),
              getVerticalSpace(),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: NORMAL_PADDING),
                    child: Icon(Icons.email_rounded, color: Colors.grey.withOpacity(0.4),size: 18),
                  ),
                  setMediumLabel("Email"),
                ],
              ),
              getVerticalSpace(),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey.withOpacity(0.2)),
                child: TextField(
                  onChanged: (_){
                    _controller.userEmail(_);

                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: LARGE_PADDING),
                      hintText: "johndoe@hotmail.com",
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
              ),
              getVerticalSpace(),
             Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: NORMAL_PADDING),
                    child: Icon(Icons.email_rounded, color: Colors.grey.withOpacity(0.4),size: 18),
                  ),
                  setMediumLabel("Phone"),
                ],
              ),
              getVerticalSpace(),
              Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey.withOpacity(0.2)),
                child: TextField(
                  onChanged: (_){
                    _controller.userPhone(_);

                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: LARGE_PADDING),
                      hintText: "9876 *** ****",
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
                    color: Colors.grey.withOpacity(0.2)), child:
              TextField(
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
                  setMediumLabel("Confirm Password"),
                ],
              ),
              getVerticalSpace(),
              Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey.withOpacity(0.2)), child:
              TextField(
                onChanged: (_){
                  _controller.userConfirmPass(_);

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
              Container(
                  width: double.infinity,
                  child: getSecondaryButton("REGISTER", () {
                    _controller.signUpUser();

                  })),
              getVerticalSpace(),
              getVerticalSpace(),
              getVerticalSpace(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  setMediumLabel("Already Have an account?"),
                  getHorizontalSpace(),
                  InkWell(
                      onTap: (){
                        Get.back();
                      },
                      child: setMediumLabel("LOGIN", color: Colors.red,decoration: TextDecoration.underline)),
                ],
              ),
              getVerticalSpace(),
              getVerticalSpace(),
              getVerticalSpace(),
          /*    getVerticalSpace(),
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
              Center(child: setMediumLabel("Login with social networks")),
              getVerticalSpace(),
              getVerticalSpace(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/facebook-app-symbol.png",
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
              )*/
            ],
          ),
        ),
      )),
    );
  }
}
