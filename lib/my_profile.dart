import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_partners/AppColors.dart';
import 'package:tida_partners/change_password_view.dart';
import 'package:tida_partners/utilss/theme.dart';

import 'controllers/ProfileController.dart';
import 'login_screen.dart';
import 'utilss/SharedPref.dart';

class MyProfile extends StatelessWidget {
  MyProfile({Key? key}) : super(key: key);
  // final c = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (c) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: PRIMARY_COLOR,
            title: setHeadlineMedium("My Profile", color: Colors.white),
            actions: [
              c.isEditing!
                  ? Container()
                  : InkWell(
                      onTap: () {
                        c.isEditing = !c.isEditing!;
                        c.update();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
            ],
          ),
          body: ListView(
            children: <Widget>[
              Container(
                height: 250,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.red, Colors.deepOrange.shade300],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [0.5, 0.9],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.white70,
                          minRadius: 55.0,
                          child: CircleAvatar(
                            radius: 50.0,
                            backgroundColor: Colors.white,
                            child: Image.network(
                                'https://tidasports.com/wp-content/uploads/2022/11/Tida-Logo-1.png'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    c.isEditing!
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 80,
                            ),
                            child: TextField(
                              controller: c.nameCtrl,
                              keyboardType: TextInputType.name,
                              decoration: const InputDecoration(
                                  focusColor: Colors.white,
                                  hintText: "Enter Name",
                                  hintStyle: TextStyle(color: Colors.white)),
                              style: const TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ))
                        : Text(
                            Preferences.getName() ?? 'Tida Sports',
                            style:
                                const TextStyle(fontSize: 24, color: Colors.white),
                          ),
                    // setPrimaryTextLarge(Preferences.getName(), color: Colors.white)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    setPrimaryTextLarge("Email", color: PRIMARY_COLOR),
                   c.isEditing! ? TextField(
                            controller: c.emCtrl,
                            decoration: const InputDecoration(
                              hintText: "Enter email",
                            ),
                           keyboardType: TextInputType.emailAddress,
                          )
                        : setPrimaryTextLarge(
                        Preferences.getEmail().toString().capitalizeFirst!),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    setPrimaryTextLarge("Phone", color: PRIMARY_COLOR),
                    c.isEditing!
                        ? TextFormField(
                            controller: c.phCtrl,
                            decoration: const InputDecoration(
                              hintText: "Enter Phone Number",
                            ),
                           keyboardType: TextInputType.phone,

                            // readOnly: true,
                          )
                        : setPrimaryTextLarge(Preferences.getPhone()),
                  ],
                ),
              ),
              
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    !c.isEditing! ?
                    Container(
                      width: double.infinity,
                      child: getSecondaryButton("Change Password", () {
                        Get.offAll(() => ChangePasswordView());
                      }),
                    ) : Container(
                      height: 0, width: 0,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    c.isEditing! ?
                    Container(
                      width: double.infinity,
                      child: getSecondaryButton("Save", () {
                        c.saving();
                      }),
                    ) : Container(
                      width: double.infinity,
                      child: getSecondaryButton("Logout", () {
                        Preferences.clearAll();
                        Get.offAll(() => LoginScreen());
                      }),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                      !c.isEditing! ?
                    Obx(() => c.isLoading.value
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : InkWell(
                            onTap: () {
                              Get.dialog(Center(
                                child: Wrap(
                                  children: [
                                    Material(
                                      type: MaterialType.transparency,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 35, vertical: 24),
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 25),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16),
                                            color: Colors.white),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: setPrimaryTextMed(
                                                        "Once the delete request is initiated, you would be no longer to access your account. Your data will be removed from servers in 14 days from the date of deletion request"))
                                              ],
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                getPrimaryButton("Delete", () {
                                                  Get.back();
                                                  c.deleteProfile();
                                                }),
                                                getPrimaryButton("Back", () {
                                                  Get.back();
                                                })
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                            },
                            child: setTextButton(
                              "Delete Account",
                            ))) : Container( height: 0,)
                  ],
                ),
              )
            ],
          ),
        );
      }
    );
  }
}
