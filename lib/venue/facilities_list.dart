import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_partners/controllers/FacilityController.dart';
import 'package:tida_partners/controllers/HomeScreenController.dart';

import '../AppColors.dart';
import '../booking_slot/facilty_slots_view.dart';
import '../network/responses/facilityListResponse.dart' as aa;
import '../utilss/theme.dart';
import 'add_facility.dart';

class FacilitiesList extends StatelessWidget {
  FacilitiesList({Key? key}) : super(key: key);
  final _controller = Get.put(FacilityController(), permanent: true);
  final _homeController = Get.put(HomeScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: setHeadlineMedium("Facilities"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: PRIMARY_COLOR,
        onPressed: () async {
          _controller.isEdit(false);
          _controller.selectedIndex((-1));
          _controller.reset();

          await Get.to(() => AddFacility());
          _controller.fetchFacilities();
        },
        child: Icon(Icons.add),
      ),
      body: Obx(() => _controller.isLoading.value
          ? showLoader()
          : _controller.dataResponse.isNotEmpty
              ? ListView.builder(
                  itemCount: _controller.dataResponse.length,
                  itemBuilder: (context, index) {
                    aa.Data item = _controller.dataResponse[index];
                    return Card(
                      elevation: 0.5,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Column(
                          children: [
                            ListTile(
                              trailing: Container(
                                // width: 80,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // setMediumLabel(
                                    //     "Status (${_controller.status.value ? "Active" : "Inactive"})"),
                                    Switch(
                                      value: item.status == "1",
                                      onChanged: (_) {
                                        if (item.status == "0")
                                          item.status = "1";
                                        else
                                          item.status = "0";
                                        _controller.update();
                                        Map<String, String> datas = {
                                          "title": item.title.toString(),
                                          "venue_id": _homeController
                                              .getSelectedVenue()
                                              .id
                                              .toString(),
                                          "id": item.id.toString(),
                                          "no_of_inventories": /*inventoryCountController.text*/
                                              "100",
                                          "min_players": /*minPlayerCtrl.text*/
                                              "12",
                                          "max_players": /*maxPlayerCtrl.text*/
                                              "12",
                                          "default_players": "12",
                                          "price_per_slot":
                                              item.pricePerSlot.toString(),
                                          "opening_time":
                                              item.openingTime.toString(),
                                          "closing_time":
                                              item.closingTime.toString(),
                                          "available_24_hours":
                                              item.available24Hours.toString(),
                                          "slot_length_hrs": "0",
                                          "slot_length_min":
                                              item.slotLengthMin.toString(),
                                          "slot_frequency": "1",
                                          "activity": item.status == "1"
                                              ? "true"
                                              : "false",
                                          "status": item.status.toString(),
                                        };
                                        print("$datas-------------");
                                        _controller.saveFacility(datas, true);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              // Wrap(
                              //   spacing: 5, // space between two icons
                              //   children: <Widget>[
                              //     // getPrimaryButton("View", () {
                              //     //   _controller.selectedIndex(index);
                              //     //   Get.to(() => FacilitySlotsView(), arguments: {"Title": item.title });
                              //     // }), // icon-1
                              //     // getPrimaryButton("Edit", () async { _controller.selectedIndex(index);
                              //     // _controller.isEdit(true);
                              //     // _controller.prefillData();
                              //     // await Get.to(() => AddFacility());
                              //     // _controller.fetchFacilities(); }), // icon-2
                              //   ],
                              // ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  setHeadlineMedium(
                                      "${item.title} (${item.openingTime} - ${item.closingTime})" ??
                                          "N/A",
                                      color: Colors.black,
                                      fontSize: SMALL_FONT),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: setMediumLabel("Click on + Icon to add Facility."))),
    );
  }
}
