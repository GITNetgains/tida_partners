import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_partners/controllers/FacilityController.dart';

import '../AppColors.dart';
import '../booking_slot/facilty_slots_view.dart';
import '../network/responses/facilityListResponse.dart' as aa;
import '../utilss/theme.dart';
import 'add_facility.dart';

class FacilitiesList extends StatelessWidget {
  FacilitiesList({Key? key}) : super(key: key);
  final _controller = Get.put(FacilityController(), permanent: true);

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
                              trailing: Wrap(
                                spacing: 5, // space between two icons
                                children: <Widget>[
                                  getPrimaryButton("View", () {
                                    _controller.selectedIndex(index);
                                    Get.to(() => FacilitySlotsView(), arguments: {"Title": item.title });
                                  }), // icon-1
                                  getPrimaryButton("Edit", () async { _controller.selectedIndex(index);
                                  _controller.isEdit(true);
                                  _controller.prefillData();
                                  await Get.to(() => AddFacility());
                                  _controller.fetchFacilities(); }), // icon-2
                                ],
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  setHeadlineMedium(item.title ?? "N/A",
                                      color: Colors.black),
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
