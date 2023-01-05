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
  final _controller = Get.put(AcademyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      drawer: NavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(()=> AddAcademy());
        },
        backgroundColor: PRIMARY_COLOR,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: setHeadlineMedium("Academies"),
      ),
      drawerDragStartBehavior: DragStartBehavior.start,
      body: Obx(() => _controller.loading.value?showLoader():Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 8),
        child: Container(
          child: ListView.builder(
            itemCount: _controller.dataList.length,
            itemBuilder: (context, index) {
               Data item = _controller.dataList[index];
              return Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: double.infinity,
                        child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5),
                                topLeft: Radius.circular(5)),
                            child: Image.network(
                                "https://content.jdmagicbox.com/comp/chandigarh/e2/0172px172.x172.180301114625.n3e2/catalogue/mohali-golf-range-chandigarh-sector-65-phase-11-chandigarh-golf-clubs-qfmd8cttlx.jpg?clr=661a00",
                                height: 130,
                                fit: BoxFit.fitWidth))),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    setHeadlineMedium(item.name??"N/A",
                                        color: Colors.black),
                                    setMediumLabel(item.address??"N/A",
                                        color: Colors.grey),
                                  ],
                                ),
                              ),
                              const CircleAvatar(
                                child: Icon(Icons.edit),
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.grey,
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: SizeConfig.screenWidth/2.5,
                                child: OutlinedButton(
                                  onPressed: null,
                                  style: ButtonStyle(
                                    side: MaterialStateProperty.all(BorderSide(color: PRIMARY_COLOR)),
                                    foregroundColor:MaterialStateProperty.all(Colors.red),
                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
                                  ),
                                  child: const Text("Manage Packages"),
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
        ),
      )),
    );
  }
}

