import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_partners/controllers/SelectAcademyController.dart';
import 'package:tida_partners/network/responses/academy_res.dart';
import 'package:tida_partners/utilss/theme.dart';

import '../AppColors.dart';

class SelectAcademy extends StatelessWidget {
  SelectAcademy({Key? key}) : super(key: key);
  final _controller = Get.put(SelectAcademyController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Academy'),
        backgroundColor: PRIMARY_COLOR,

      ),
      body:Obx(() =>  _controller.loading.value?showLoader():_controller.academyList.isNotEmpty?ListView.builder(
        itemBuilder: (builder, index) {
          Data data = _controller.academyList[index];

          return Column(
            children: [
              ListTile(
                onTap: () => _controller.selectVenue(index),
                title: setMediumLabel(data.name?.toUpperCase()??"N/A"),
                subtitle:setSmallLabel(data.address??"N/A") ,

              ),
              const Divider(
                color: Colors.grey,
              )
            ],
          );
        },
        itemCount: _controller.academyList.length,
      ):Center(child: setSmallLabel("Please add academy to contnue adding tournament."),)),
    );
  }


}
