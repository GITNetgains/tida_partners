import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_partners/controllers/FacilityController.dart';

import '../AppColors.dart';
import '../utilss/theme.dart';

class AddFacility extends StatelessWidget {
  AddFacility({Key? key}) : super(key: key);
  final _controller = Get.put(FacilityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: Obx(() => setHeadlineMedium("${_controller.isEdit.value?"Edit":"Add"} Facility")),
      ),
      body: Obx(() => _controller.isLoading.value?showLoader(message: "Saving Facility..."):Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            getVerticalSpace(),
            TextField(
              controller: _controller.titleController,
              onChanged: (_) {},
              textAlignVertical: TextAlignVertical.top,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                label: setMediumLabel(
                  "Title",
                ),
                alignLabelWithHint: true,
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: PRIMARY_COLOR),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                ),
              ),
            ),
            getVerticalSpace(),
           /* TextField(
              controller: _controller.inventoryCountController,
              onChanged: (_) {},
              textAlignVertical: TextAlignVertical.top,
              cursorColor: Colors.black,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: setMediumLabel(
                  "Number of Inventories",
                ),
                alignLabelWithHint: true,
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: PRIMARY_COLOR),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                ),
              ),
            ),*/
          //  getVerticalSpace(),
         /*   TextField(
              controller: _controller.minPlayerCtrl,
              onChanged: (_) {},
              textAlignVertical: TextAlignVertical.top,
              cursorColor: Colors.black,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: setMediumLabel(
                  "Minimum Players",
                ),
                alignLabelWithHint: true,
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: PRIMARY_COLOR),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                ),
              ),
            ),
            getVerticalSpace(),
            TextField(
              controller: _controller.maxPlayerCtrl,
              onChanged: (_) {},
              textAlignVertical: TextAlignVertical.top,
              cursorColor: Colors.black,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: setMediumLabel(
                  "Maximum Players",
                ),
                alignLabelWithHint: true,
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: PRIMARY_COLOR),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                ),
              ),
            ),*/
            getVerticalSpace(),
            TextField(
              controller: _controller.priceCtrl,
              onChanged: (_) {},
              textAlignVertical: TextAlignVertical.top,
              keyboardType: TextInputType.number,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                label: setMediumLabel(
                  "Price per slot",
                ),
                alignLabelWithHint: true,
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: PRIMARY_COLOR),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                ),
              ),
            ),
            getVerticalSpace(),
            Obx(() => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  setMediumLabel("Open 24 hours"),
                  Switch(
                    value: _controller.is24hrs.value,
                    onChanged: (_) {
                      _controller.is24hrs(_);
                    },
                  )
                ],
              ),
            )),
            getVerticalSpace(),
            Obx(() =>   Visibility(
                visible: !_controller.is24hrs.value,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        _controller.selectOpeningTime(context);
                      },
                      child: TextField(
                        controller: _controller.openingCtrl,
                        onChanged: (_) {},
                        enabled: false,
                        textAlignVertical: TextAlignVertical.top,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          label: setMediumLabel(
                            "Opening time",
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
                    ),
                    getVerticalSpace(),
                  ],
                ))),


            Obx(() => Visibility(
              visible: !_controller.is24hrs.value,
              child: Column(
                children: [InkWell(
                  onTap: () {
                    _controller.selectClosingTime(context);
                  },
                  child: TextField(
                    enabled: false,
                    controller: _controller.closingCtrl,
                    onChanged: (_) {},
                    textAlignVertical: TextAlignVertical.top,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      label: setMediumLabel(
                        "Closing time",
                      ),
                      alignLabelWithHint: true,
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: PRIMARY_COLOR),
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                      ),
                    ),
                  ),
                ),
                  getVerticalSpace(),],

              ),
            ),),
            /*TextField(
              controller: _controller.slotLHourCtrl,
              onChanged: (_) {},
              textAlignVertical: TextAlignVertical.top,
              cursorColor: Colors.black,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: setMediumLabel(
                  "Slot length Hour",
                ),
                alignLabelWithHint: true,
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: PRIMARY_COLOR),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                ),
              ),
            ),
            getVerticalSpace(),*/
            TextField(
              controller: _controller.slotLMinCtrl,
              onChanged: (_) {},
              textAlignVertical: TextAlignVertical.top,
              cursorColor: Colors.black,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: setMediumLabel(
                  "Slot length Minutes",
                ),
                alignLabelWithHint: true,
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: PRIMARY_COLOR),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                ),
              ),
            ),
            getVerticalSpace(),
           /* TextField(
              controller: _controller.freqCtrl,
              onChanged: (_) {},
              textAlignVertical: TextAlignVertical.top,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                label: setMediumLabel(
                  "Slot Frequency",
                ),
                alignLabelWithHint: true,
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: PRIMARY_COLOR),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                ),
              ),
            ),
            getVerticalSpace(),*/
            Obx(() => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  setMediumLabel(
                      "Status (${_controller.status.value ? "Active" : "Inactive"})"),
                  Switch(
                    value: _controller.status.value,
                    onChanged: (_) {
                      _controller.status(_);
                    },
                  )
                ],
              ),
            )),
            getVerticalSpace(),
            Container(
                padding: EdgeInsets.all(8),
                width: double.infinity,
                child: getSecondaryButton("Save", () {
                  _controller.saveFacility();
                })),
          ],
        ),
      )),
    );
  }
}
