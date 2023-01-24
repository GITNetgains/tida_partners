import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_partners/controllers/FacilityController.dart';
import '../network/responses/facilityListResponse.dart' as aa;

import '../AppColors.dart';
import '../utilss/theme.dart';
import 'add_facility.dart';

class FacilitiesList extends StatelessWidget {
  FacilitiesList({Key? key}) : super(key: key);
  final _controller = Get.put(FacilityController());

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
                return InkWell(
                  onTap: () async {
                    _controller.selectedIndex(index);
                    _controller.isEdit(true);
                    _controller.prefillData();
                    await Get.to(() => AddFacility());
                    _controller.fetchFacilities();
                  },
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        setHeadlineMedium(item.title ?? "N/A",
                                            color: Colors.black),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            )),
    );
  }
}
