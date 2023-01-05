import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_partners/academy/select_venue.dart';
import 'package:tida_partners/controllers/AcademyController.dart';
import 'package:tida_partners/utilss/theme.dart';

import '../AppColors.dart';

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
      ),
      body: Container(
        padding: EdgeInsets.only(top: 8, bottom: 8),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async {
                       var f= await Get.to(()=>SelectVenue());
                       _controller.update();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() =>(_controller.vData.value==null)?setHeadlineLarge("Select Venue"):setHeadlineLarge(_controller.vData.value?.title??""),),
                          Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      ),
                    ),
                  ),
                  getVerticalSpace(),
                  TextField(
                    cursorColor: Colors.black,
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
                  TextField(
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
                  getVerticalSpace(),
                  TextField(
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
                  ), getVerticalSpace(),
                  TextField(
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
                  ),getVerticalSpace(),
                  TextField(
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


                })),
          ],
        ),
      ),
    );
  }
}
