import 'dart:io';

import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_partners/controllers/tournament_controller.dart';
import 'package:tida_partners/tournaments/select_academy.dart';
import 'package:tida_partners/tournaments/sponsor_list.dart';

import '../AppColors.dart';
import '../utilss/size_config.dart';
import '../utilss/theme.dart';

class AddTournament extends StatelessWidget {
  AddTournament({Key? key}) : super(key: key);

  final _controller = Get.put(TournamentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: setHeadlineMedium("Add Tournament"),
      ),
      body: Obx(() => _controller.isLoading.value
          ? showLoader()
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () async {
                      var data = await Get.to(() => SelectAcademy());
                      _controller.setSelectedAcademy(data);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => (_controller.selectedAcademy.value == "")
                              ? setHeadlineLarge("Select Academy")
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
                      /* InkWell(
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
                      ),*/
                      getVerticalSpace(),
                      TextField(
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
                            borderSide:
                                BorderSide(width: 3, color: Colors.greenAccent),
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
                            "Registration & Entry charges",
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
                      getVerticalSpace(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: setHeadlineMedium("Select Sponsors",
                                color: PRIMARY_COLOR),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(() => SponsorList());
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: CircleAvatar(
                                  backgroundColor: PRIMARY_COLOR,
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                        ],
                      ),
                      getVerticalSpace(),
                    Obx(() => _controller.selectedSponsor.isEmpty
                        ? Container()
                        : SizedBox(
                      width: double.infinity,
                          child: ChipsChoice<String>.multiple(

                      choiceCheckmark: false,

                      value: _controller.selectedSponsor,
                      onChanged: (val) => {},
                      choiceItems: C2Choice.listFrom<String, String>(
                          source: _controller.selectedSponsor,
                          value: (i, v) => v,
                          label: (i, v) => v.toUpperCase(),
                      ),
                    ),
                        )),
                      getVerticalSpace(),
                      /* TextField(
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
                      getVerticalSpace(),*/
                      InkWell(
                        onTap: () {
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
                              borderSide: BorderSide(
                                  width: 3, color: Colors.greenAccent),
                            ),
                          ),
                        ),
                      ),
                      getVerticalSpace(),
                      InkWell(
                        onTap: () {
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
                              borderSide: BorderSide(
                                  width: 3, color: Colors.greenAccent),
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
