import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_partners/academy/select_venue.dart';
import 'package:tida_partners/controllers/ExperienceController.dart';
import 'package:tida_partners/controllers/tournament_controller.dart';
import 'package:tida_partners/experiences/experience_list.dart';
import 'package:tida_partners/tournaments/select_academy.dart';

import '../AppColors.dart';
import '../utilss/size_config.dart';
import '../utilss/theme.dart';

class AddExperiences extends StatelessWidget {
  AddExperiences({Key? key}) : super(key: key);

  final _controller = Get.put(ExperienceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: setHeadlineMedium("Add Experiences"),
      ),
      body: Obx(() => _controller.isLoading.value
          ? showLoader()
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () async {
                      var data = await Get.to(() => SelectVenue());
                      _controller.setSelectedAcademy(data);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => (_controller.selectedAcademy.value == "")
                              ? setHeadlineLarge("Select Venue")
                              : setHeadlineLarge(_controller
                                      .selectedAcademy.value
                                      .toUpperCase() ??
                                  ""),
                        ),
                        const Icon(Icons.arrow_forward_ios_rounded)
                      ],
                    ),
                  ),
                ),
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
                                      image: NetworkImage(
                                          _controller.filePath.value),
                                      height: SizeConfig.screenWidth / 2,
                                      fit: BoxFit.cover,
                                      placeholderFit: BoxFit.fitWidth,
                                      placeholder: const AssetImage(
                                        "assets/no_image.png",
                                      ),
                                      imageErrorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                            'assets/no_image.png',
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
                                    setMediumLabel("Click here to add poster")
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
                      TextField(
                        controller: _controller.titleController,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          label: setMediumLabel(
                            "Title",
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: PRIMARY_COLOR),
                          ),
                          border: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.greenAccent),
                          ),
                        ),
                      ),
                      getVerticalSpace(),
                      TextField(
                        controller: _controller.descController,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          label: setMediumLabel(
                            "Description",
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: PRIMARY_COLOR),
                          ),
                          border: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.greenAccent),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(() => setMediumLabel(
                                  "Tournament Type (${_controller.isOnline.value ? "Online" : "Offline"})")),
                              Obx(() => Switch(
                                  value: _controller.isOnline.value,
                                  onChanged: _controller.setType))
                            ],
                          ),
                        ),
                      ),
                      getVerticalSpace(),
                      Obx(
                        () => Visibility(
                          visible: _controller.isOnline.value,
                          child: TextField(
                            controller: _controller.urlController,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              label: setMediumLabel(
                                "URL",
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
                        ),
                      ),
                      getVerticalSpace(),
                      TextField(
                        controller: _controller.addressController,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          label: setMediumLabel(
                            "Address",
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: PRIMARY_COLOR),
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
                            borderSide:
                                BorderSide(width: 1, color: PRIMARY_COLOR),
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
                        controller: _controller.noOfTicketController,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          label: setMediumLabel(
                            "Number of tickets",
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: PRIMARY_COLOR),
                          ),
                          border: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.greenAccent),
                          ),
                        ),
                      ),
                      getVerticalSpace(),
                      InkWell(
                        onTap: (){
                          _controller.selectStartDate(context);

                        },
                        child: TextField(
                          enabled: false,
                          controller: _controller.startDateController,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            label: setMediumLabel(
                              "Start Date",
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: PRIMARY_COLOR),
                            ),
                            border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 3, color: Colors.greenAccent),
                            ),
                          ),
                        ),
                      ),
                      getVerticalSpace(),
                      InkWell(
                        onTap: (){
                          _controller.selectEndTime(context);

                        },
                        child: TextField(
                          enabled: false,
                          controller: _controller.endDateController,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            label: setMediumLabel(
                              "End Date",
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: PRIMARY_COLOR),
                            ),
                            border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 3, color: Colors.greenAccent),
                            ),
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
                      _controller.saveData();
                    })),
              ],
            )),
    );
  }
}
