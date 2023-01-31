import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_partners/academy/select_venue.dart';
import 'package:tida_partners/controllers/AcademyController.dart';
import 'package:tida_partners/utilss/theme.dart';

import '../AppColors.dart';
import '../utilss/size_config.dart';

class AddAcademy extends StatelessWidget {
    AddAcademy({Key? key}) : super(key: key);
  final _controller = Get.put(AcademyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: setHeadlineMedium("Add Academy details"),
        actions: [
          Obx(() => _controller.isEdit.value
              ? InkWell(
              onTap: () {
                showAlertDialog(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.delete),
              ))
              : Container())
        ],
      ),
      body: Obx(() => _controller.loading.value?showLoader():Container(
        padding: EdgeInsets.only(top: 8, bottom: 8),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: InkWell(
                  onTap: () {
                    _controller.selectImage();
                  },
                  child: Obx(() => (_controller.filePath.value.isNotEmpty)
                      ? (_controller.filePath.startsWith("https"))
                      ? ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(5),
                          topLeft: Radius.circular(5)),
                      child: Container(
                        width: double.infinity,
                        child: FadeInImage(
                          image:
                          NetworkImage(_controller.filePath.value),
                          height: SizeConfig.screenWidth / 2,
                          fit: BoxFit.cover,
                          placeholderFit: BoxFit.fitWidth,
                          placeholder: const AssetImage(
                            "assets/no_image.png",
                          ),
                          imageErrorBuilder:
                              (context, error, stackTrace) {
                            return Image.asset('assets/no_image.png',
                                fit: BoxFit.fitWidth);
                          },
                        ),
                      ))
                      : Image.file(
                    File(_controller.filePath.value),
                    height: SizeConfig.screenWidth / 2,
                    fit: BoxFit.cover,
                  )
                      : SizedBox(
                    width: 100,
                    height: 100,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add),
                          setMediumLabel("Click here to add Academy image")
                        ],
                      ),
                    ),
                  )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async {
                        var data= await Get.to(()=>SelectVenue());

                        _controller.setSelectedVenue(data);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() =>(_controller.selectedVenue.value=="")?setHeadlineLarge("Select Venue"):setHeadlineLarge(_controller.selectedVenue.value.toUpperCase()??""),),
                          const Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      ),
                    ),
                  ),
                  getVerticalSpace(),
                  TextField(
                    cursorColor: Colors.black,
                    controller: _controller.academyCtrl,
                    decoration: InputDecoration(
                      label: setMediumLabel(
                        "Academy Name",
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: PRIMARY_COLOR),
                      ),
                      border: const OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 3, color: Colors.greenAccent),
                      ),
                    ),
                  ),
                  getVerticalSpace(),
                  TextField(
                    controller: _controller.descriptionCtrl,
                    textAlignVertical: TextAlignVertical.top,
                    cursorColor: Colors.black,
                    maxLines: 5,
                    decoration: InputDecoration(
                      label: setMediumLabel(
                        "Description",
                      ),
                      alignLabelWithHint: true,
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: PRIMARY_COLOR),
                      ),
                      border: const OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 3, color: Colors.greenAccent),
                      ),
                    ),
                  ),
                  getVerticalSpace(),
                  TextField(
                    controller: _controller.locationCtrl,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      label: setMediumLabel(
                        "Location",
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: PRIMARY_COLOR),
                      ),
                      border: const OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 3, color: Colors.greenAccent),
                      ),
                    ),
                  ),

                  getVerticalSpace(),
                  TextField(
                    controller: _controller.headCoachCtrl,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      label: setMediumLabel(
                        "Head Coach",
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: PRIMARY_COLOR),
                      ),
                      border: const OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 3, color: Colors.greenAccent),
                      ),
                    ),
                  ),
                  getVerticalSpace(),
                  TextField(
                    controller: _controller.timeCtrl,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      label: setMediumLabel(
                        "Time Availability",
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: PRIMARY_COLOR),
                      ),
                      border: const OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 3, color: Colors.greenAccent),
                      ),
                    ),
                  ),
                  getVerticalSpace(),
                  TextField(
                    controller: _controller.contactCtrl,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      label: setMediumLabel(
                        "Contact Number",
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: PRIMARY_COLOR),
                      ),
                      border: const OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 3, color: Colors.greenAccent),
                      ),
                    ),
                  ),
                  getVerticalSpace(),
                 /* TextField(
                    controller: _controller.serviceCtrl,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      label: setMediumLabel(
                        "Services",
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: PRIMARY_COLOR),
                      ),
                      border: const OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 3, color: Colors.greenAccent),
                      ),
                    ),
                  ),
                  getVerticalSpace(),*/
                  TextField(
                    controller: _controller.skillCtrl,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      label: setMediumLabel(
                        "Skill Level",
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: PRIMARY_COLOR),
                      ),
                      border: const OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 3, color: Colors.greenAccent),
                      ),
                    ),
                  ),
                  getVerticalSpace(),
                  TextField(
                    controller: _controller.ageCtrl,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      label: setMediumLabel(
                        "Age Group",
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: PRIMARY_COLOR),
                      ),
                      border: const OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 3, color: Colors.greenAccent),
                      ),
                    ),
                  ),
                  getVerticalSpace(),
                  TextField(
                    controller: _controller.groundSizeCtrl,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      label: setMediumLabel(
                        "Ground Size",
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: PRIMARY_COLOR),
                      ),
                      border: const OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 3, color: Colors.greenAccent),
                      ),
                    ),
                  ),getVerticalSpace(),
                  TextField(
                    controller: _controller.capacityNameCtrl,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      label: setMediumLabel(
                        "Capacity",
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: PRIMARY_COLOR),
                      ),
                      border: const OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 3, color: Colors.greenAccent),
                      ),
                    ),
                  ),getVerticalSpace(),
                  TextField(
                    controller: _controller.floodLightCtrl,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      label: setMediumLabel(
                        "Flood Lights",
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: PRIMARY_COLOR),
                      ),
                      border: const OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 3, color: Colors.greenAccent),
                      ),
                    ),
                  ),
                  getVerticalSpace(),
                  TextField(
                    controller: _controller.equipmentCtrl,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      label: setMediumLabel(
                        "Equipment",
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: PRIMARY_COLOR),
                      ),
                      border: const OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 3, color: Colors.greenAccent),
                      ),
                    ),
                  ),
                  getVerticalSpace(),
                  TextField(
                    controller: _controller.coachExpCtrl,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      label: setMediumLabel(
                        "Coach Experience",
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: PRIMARY_COLOR),
                      ),
                      border: const OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 3, color: Colors.greenAccent),
                      ),
                    ),
                  ),getVerticalSpace(),
                  TextField(
                    controller: _controller.noOfAssistantCtrl,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      label: setMediumLabel(
                        "No. of Assistant Coach",
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: PRIMARY_COLOR),
                      ),
                      border: const OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 3, color: Colors.greenAccent),
                      ),
                    ),
                  ),getVerticalSpace(),
                  TextField(
                    controller: _controller.assistantCoachNameCtrl,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      label: setMediumLabel(
                        "Assistant Coach Name",
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: PRIMARY_COLOR),
                      ),
                      border: const OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 3, color: Colors.greenAccent),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),

            getVerticalSpace(),
            Container(
                padding: EdgeInsets.all(8),
                width: double.infinity,
                child: getSecondaryButton("Save", () {
                  _controller.saveAcademy();

                })),
          ],
        ),
      )),
    );
  }

    showAlertDialog(BuildContext context) {
      // Create button
      Widget okButton = TextButton(
        child: const Text(
          "OK",
          style: TextStyle(color: PRIMARY_COLOR),
        ),
        onPressed: () {
          _controller.deletePackage(isAcademy: true);
          Get.back();

        },
      );

      // Create AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Delete"),
        content: const Text("Do you want to delete this academy?"),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
}
