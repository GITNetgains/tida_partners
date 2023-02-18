import 'dart:io';

import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_partners/controllers/HomeScreenController.dart';
import 'package:tida_partners/controllers/VenueDetailsController.dart';
import 'package:tida_partners/utilss/size_config.dart';
import 'package:tida_partners/utilss/theme.dart';
import 'package:tida_partners/venue/selec_sports.dart';

import 'AppColors.dart';
import 'venue/select_amenities.dart';
import 'venue/venue_image_gallery.dart';

class AddVenue extends StatelessWidget {
  AddVenue({Key? key}) : super(key: key);
  final _controller = Get.put(VenueDetailsController());
  final _controllerHome = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: Obx(() => setHeadlineMedium(
            !_controllerHome.isEdit.value ? "Add Venue" : "Edit Venue")),
      ),
      body: Obx(() => _controller.loading.value
          ? showLoader()
          : Container(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: InkWell(
                          onTap: () {
                            _controller.selectImage();
                          },
                          child: Obx(() => (_controller.filePath.value.isNotEmpty)
                              ? (_controller.filePath.startsWith("http"))
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
                                  setMediumLabel(
                                      "Click here to add venue images")
                                ],
                              ),
                            ),
                          )),
                        ),
                      ),
                        _controller.filePath.value.isEmpty?Container(): Positioned(
                            bottom: 1,
                            right: 1,
                            child: InkWell(
                              onTap: (){
                                _controller.selectImage();

                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.black.withOpacity(0.7),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.edit, color: Colors.white,),
                                  ),
                                ),
                              ),
                            ))

                      ],
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextField(
                          cursorColor: Colors.black,
                          onChanged: (_) {
                            _controller.venueName(_);
                          },
                          controller: _controller.titleController,
                          decoration: InputDecoration(
                            label: setMediumLabel(
                              "Venue Name",
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
                        TextField(
                          onChanged: (_) {
                            _controller.vDescription(_);
                          },
                          controller: _controller.desController,
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
                        _controller.selectLocation(),
                        getVerticalSpace(),
                     /*   InkWell(
                          onTap: (){
                            _controller.selectOpeningTime(context);

                          },
                          child: TextField(
                            enabled: false,
                            onChanged: (_) {
                              _controller.vTimeAvailabilty(_);
                            },
                            controller: _controller.openingCtrl,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              label: setMediumLabel(
                                "Opening time",
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
                          onTap: (){
                            _controller.selectOpeningTime(context);

                          },
                          child: TextField(
                            enabled: false,
                            onChanged: (_) {
                              _controller.vTimeAvailabilty(_);
                            },
                            controller: _controller.closingCtrl,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              label: setMediumLabel(
                                "Closing time",
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
                        getVerticalSpace(),*/
                     /*   TextField(
                          onChanged: (_) {
                            _controller.vTax(_);
                          },
                          controller: _controller.taxCtrl,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            label: setMediumLabel(
                              "Tax Applicable",
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
                        getVerticalSpace(),*/
                        TextField(
                          onChanged: (_) {
                            _controller.vTax(_);
                          },
                          controller: _controller.videoCtrl,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            label: setMediumLabel(
                              "Video Url",
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
                      ],
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  getVerticalSpace(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: setHeadlineMedium("Select Amenities",
                            color: PRIMARY_COLOR),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => SelectAmenities());
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(right: 16.0),
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
                  Obx(() => _controller.tags.isEmpty
                      ? Container()
                      : ChipsChoice<String>.multiple(
                          wrapped: true,
                          choiceCheckmark: false,
                          value: _controller.tags,
                          onChanged: (val) => {},
                          choiceItems: C2Choice.listFrom<String, String>(
                            source: _controller.tags,
                            value: (i, v) => v,
                            label: (i, v) => v.toUpperCase(),
                          ),
                        )),
                  const Divider(
                    color: Colors.grey,
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  getVerticalSpace(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: setHeadlineMedium("Select Sports",
                            color: PRIMARY_COLOR),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => SelectSports());
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(right: 16.0),
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
                  Obx(() => _controller.selectedSport.isEmpty
                      ? Container()
                      : ChipsChoice<String>.multiple(
                          wrapped: true,
                          choiceCheckmark: false,
                          value: _controller.selectedSport,
                          onChanged: (val) => {},
                          choiceItems: C2Choice.listFrom<String, String>(
                            source: _controller.selectedSport,
                            value: (i, v) => v,
                            label: (i, v) => v.toUpperCase(),
                          ),
                        )),
                  const Divider(
                    color: Colors.grey,
                  ),
                  getVerticalSpace(),
                  Visibility(
                    visible: _controllerHome.isEdit.value,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: setHeadlineMedium("Gallery",
                              color: PRIMARY_COLOR),
                        ),
                        InkWell(
                          onTap: () async {
                            _controllerHome.imageList.clear();
                            await _controllerHome.fetchMedia();
                            Get.to(() => VenueImageGallery());
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(right: 16.0),
                            child: CircleAvatar(
                                backgroundColor: PRIMARY_COLOR,
                                child: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  getVerticalSpace(),
                  Container(
                      padding: const EdgeInsets.all(8),
                      width: double.infinity,
                      child: getSecondaryButton("Save", () {
                        _controller.saveVenue();
                      })),
                ],
              ),
            )),
    );
  }
}
