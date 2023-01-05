import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_partners/controllers/SelectVenueController.dart';
import 'package:tida_partners/network/responses/VenueListResponse.dart' as v;
import 'package:tida_partners/utilss/theme.dart';

import '../AppColors.dart';

class SelectVenue extends StatelessWidget {
    SelectVenue({Key? key}) : super(key: key);
  final _controller = Get.put(SelectVenueController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Venue'),
        backgroundColor: PRIMARY_COLOR,

      ),
      body:Obx(() =>  _controller.loading.value?showLoader():ListView.builder(
        itemBuilder: (builder, index) {
          v.Data data = _controller.venueList[index];

          return Column(
            children: [
              ListTile(
                onTap: () => _controller.selectVenue(index),
                title: setMediumLabel(data.title?.toUpperCase()??"N/A"),
                subtitle:setSmallLabel(data.address??"N/A") ,

              ),
              const Divider(
                color: Colors.grey,
              )
            ],
          );
        },
        itemCount: _controller.venueList.length,
      )),
    );
  }


}
