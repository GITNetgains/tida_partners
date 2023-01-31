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
            _controller.isEditPackage.value ? "Edit package" : "Add Package")),
        actions: [
          Obx(() => _controller.isEditPackage.value
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
      body: Obx(() => _controller.loading.value
          ? showLoader()
          : Container(
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
                              borderSide:
                                  BorderSide(width: 1, color: PRIMARY_COLOR),
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Colors.greenAccent),
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
                              borderSide:
                                  BorderSide(width: 1, color: PRIMARY_COLOR),
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Colors.greenAccent),
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
                              borderSide:
                                  BorderSide(width: 1, color: PRIMARY_COLOR),
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Colors.greenAccent),
                            ),
                          ),
                        ),
                        getVerticalSpace(),
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
                        _controller.savePackage();
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
        Get.back();
        _controller.deletePackage();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete"),
      content: const Text("Do you want to delete this package?"),
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
