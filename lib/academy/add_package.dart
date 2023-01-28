import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_partners/controllers/AcademyController.dart';

import '../AppColors.dart';
import '../utilss/size_config.dart';
import '../utilss/theme.dart';

class AddPackage extends StatelessWidget {
  AddPackage({Key? key}) : super(key: key);
  final _controller = Get.put(AcademyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: Obx(() => setHeadlineMedium(
            _controller.isEdit.value ? "Edit package" : "Add Package")),
      ),
      body: Obx(() => _controller.loading.value?showLoader():Container(
        padding: EdgeInsets.only(top: 8, bottom: 8),
        child: ListView(
          children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [

                  TextField(
                    cursorColor: Colors.black,
                    controller: _controller.packageTitleController,
                    decoration: InputDecoration(
                      label: setMediumLabel(
                        "Package Name",
                      ),
                      hintText: "Eg: Trial Pack (3 days)",
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
                    keyboardType: TextInputType.number,
                    controller: _controller.priceController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      label: setMediumLabel(
                        "Price",
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
}
