import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_partners/add_venue.dart';
import 'package:tida_partners/controllers/FacilityController.dart';
import 'package:tida_partners/nab_bar.dart';
import 'package:tida_partners/network/responses/VenueListResponse.dart';
import 'package:tida_partners/slot_booking_screen.dart';
import 'package:tida_partners/utilss/size_config.dart';
import 'package:tida_partners/utilss/theme.dart';
import 'package:tida_partners/venue/facilities_list.dart';

import 'AppColors.dart';
import 'controllers/HomeScreenController.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final _controller = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: NavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _controller.isEdit(false);
          await Get.to(() => AddVenue());
          _controller.fetch();
        },
        backgroundColor: PRIMARY_COLOR,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: setHeadlineMedium("Venues"),
      ),
      drawerDragStartBehavior: DragStartBehavior.start,
      body: RefreshIndicator(
        onRefresh: () async {
          return _controller.fetch();
        },
        child: Obx(() => _controller.loading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding:
                    const EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 8),
                child: Obx(() => _controller.venueList.isNotEmpty
                    ? ListView.builder(
                        itemCount: _controller.venueList.length,
                        itemBuilder: (context, index) {
                          Data item = _controller.venueList[index];
                          return Container(
                            margin: EdgeInsets.only(
                                bottom: (index ==_controller.venueList.length-1  &&_controller.venueList.length != 1)?100:0),

                            child: Card(
                              elevation: 5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                  //  _controller.viewVenue(index);
                                      _controller.editVenue(index);

                                    },
                                    child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(5),
                                            topLeft: Radius.circular(5)),
                                        child: getImageWidget(item.image??"-")),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  setHeadlineMedium(
                                                      item.title ?? "N/A",
                                                      color: Colors.black),
                                                  setMediumLabel(
                                                      item.address ?? "N/A",
                                                      color: Colors.grey),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 18.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width:
                                                SizeConfig.screenWidth / 1.3,
                                                child: OutlinedButton(
                                                  onPressed: () async {
                                                    _controller.index(index);
                                                    bool test = Get.isRegistered<FacilityController>();
                                                    if (test) {
                                                      final _c = Get.put(FacilityController());
                                                      _c.onInit();
                                                    }
                                                  await   Get.to(() => FacilitiesList());

                                                  },
                                                  style: ButtonStyle(
                                                    side: MaterialStateProperty
                                                        .all(const BorderSide(
                                                        color:
                                                        PRIMARY_COLOR)),
                                                    foregroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.red),
                                                    shape: MaterialStateProperty
                                                        .all(RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            30.0))),
                                                  ),
                                                  child: const Text(
                                                      "Manage Facilities"),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  _controller.editVenue(index);
                                                },
                                                child: const CircleAvatar(
                                                  foregroundColor: Colors.white,
                                                  backgroundColor: Colors.grey,
                                                  child: Icon(Icons.edit),
                                                ),
                                              )


                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : Center(
                        child: setMediumLabel(
                            "Please click on + button to add venue."),
                      )),
              )),
      ),
    );
  }
}
