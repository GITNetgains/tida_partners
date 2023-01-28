import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_partners/academy/add_acedemy.dart';
import 'package:tida_partners/add_venue.dart';
import 'package:tida_partners/controllers/AcademyController.dart';
import 'package:tida_partners/nab_bar.dart';
import 'package:tida_partners/network/responses/academy_res.dart';
import 'package:tida_partners/utilss/size_config.dart';
import 'package:tida_partners/utilss/theme.dart';

import '../AppColors.dart';
import 'academy_package_list.dart';

class AcademyList extends StatelessWidget {
  AcademyList({Key? key}) : super(key: key);
  final _controller = Get.put(AcademyController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      drawer: NavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _controller.selectedVenue("");
          _controller.vData(null);
          _controller.resetData();
          var data = await Get.to(() => AddAcademy());
          if (data!!) {
            _controller.getAllAcademies();
          }
        },
        backgroundColor: PRIMARY_COLOR,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: setHeadlineMedium("Academies"),
      ),
      drawerDragStartBehavior: DragStartBehavior.start,
      body: RefreshIndicator(
        onRefresh: () async {
          return _controller.getAllAcademies();
        },
        child: Obx(() => _controller.loading.value
            ? showLoader()
            : _controller.dataList.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 8, left: 8, right: 8),
                    child: ListView.builder(
                      itemCount: _controller.dataList.length,
                      itemBuilder: (context, index) {
                        Data item = _controller.dataList[index];
                        return Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(5),
                                      topLeft: Radius.circular(5)),
                                  child: getImageWidget(item.logo ?? "-")),
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
                                              setHeadlineMedium(
                                                  item.name ?? "N/A",
                                                  color: Colors.black),
                                              setMediumLabel(
                                                  item.address ?? "N/A",
                                                  color: Colors.grey),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          width: SizeConfig.screenWidth / 1.3,
                                          child: OutlinedButton(
                                            onPressed: () {
                                              _controller.isEditPackage(false);
                                              Get.to(() =>   AcademyPackageList());
                                            },
                                            style: ButtonStyle(
                                              side: MaterialStateProperty.all(
                                                  const BorderSide(
                                                      color: PRIMARY_COLOR)),
                                              foregroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.red),
                                              shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.0))),
                                            ),
                                            child:
                                                const Text("Manage Packages"),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.to(() => AddAcademy());
                                            _controller.isEdit(true);
                                            _controller.selectedIndex(index);
                                            _controller.setAcademyData();
                                          },
                                          child: const CircleAvatar(
                                            child: Icon(Icons.edit),
                                            foregroundColor: Colors.white,
                                            backgroundColor: Colors.grey,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  )
                : const Center(
                    child: Text("Please add academy by clicking on + icon"),
                  )),
      ),
    );
  }
}
