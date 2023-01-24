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
                                  child: Container(
                                    width: double.infinity,
                                    child: FadeInImage(
                                      image: NetworkImage('${item.logo}'),
                                      height: 130,
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
                                  )),
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
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: SizeConfig.screenWidth / 2.5,
                                          child: OutlinedButton(
                                            onPressed: null,
                                            style: ButtonStyle(
                                              side: MaterialStateProperty.all(
                                                  BorderSide(
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
