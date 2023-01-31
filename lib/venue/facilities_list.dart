import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_partners/controllers/FacilityController.dart';
import 'package:tida_partners/slot_booking_screen.dart';
import '../network/responses/facilityListResponse.dart' as aa;

import '../AppColors.dart';
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
        onPressed: () {
          Get.to(() => AddFacility());
        },
        child: Icon(Icons.add),
      ),
      body: Obx(() => _controller.isLoading.value
          ? showLoader()
          : ListView.builder(
              itemCount: _controller.dataResponse.length,
              itemBuilder: (context, index) {
                aa.Data item = _controller.dataResponse[index];
                return Column(
                  children: [
                    ListTile(
                      trailing: Wrap(
                        spacing: 20, // space between two icons
                        children: <Widget>[
                          InkWell(
                              onTap: () {
                                _controller.selectedIndex(index);
                                Get.to(() => SlotBookingScreen());

                              },
                              child: Icon(Icons.edit_note)), // icon-1
                          InkWell(
                              onTap: () async {
                                _controller.selectedIndex(index);
                                _controller.isEdit(true);
                                _controller.prefillData();
                                await Get.to(() => AddFacility());
                                _controller.fetchFacilities();
                              },
                              child: Icon(Icons.edit)), // icon-2
                        ],
                      ),
                      title: Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            setHeadlineMedium(item.title ?? "N/A",
                                color: Colors.black),
                          ],
                        ),
                      ),
                    ),
                    Divider()
                  ],
                );
              },
            )),
    );
  }
}
