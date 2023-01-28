import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_partners/add_venue.dart';
import 'package:tida_partners/booking_cal.dart';
import 'package:tida_partners/nab_bar.dart';
import 'package:tida_partners/network/responses/VenueListResponse.dart';
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
      backgroundColor: Colors.white.withOpacity(0.95),
      drawer: NavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.isEdit(false);
          Get.to(() => AddVenue());
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
                          return Card(
                            elevation: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    _controller.viewVenue(index);
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
                                          Column(
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
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 18.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              child: OutlinedButton(
                                                onPressed: () {
                                                  /*      Get.to(() =>
                                                      BookingCalendarDemoApp(
                                                          title: "Bookings"));*/
                                                },
                                                style: ButtonStyle(
                                                  side: MaterialStateProperty
                                                      .all(BorderSide(
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
                                                child: const Text("Bookings"),
                                              ),
                                              width:
                                                  SizeConfig.screenWidth / 2.5,
                                            ),
                                            Container(
                                              width:
                                                  SizeConfig.screenWidth / 2.5,
                                              child: OutlinedButton(
                                                onPressed: () {
                                                  Get.to(
                                                      () => FacilitiesList());
                                                },
                                                style: ButtonStyle(
                                                  side: MaterialStateProperty
                                                      .all(BorderSide(
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
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
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
