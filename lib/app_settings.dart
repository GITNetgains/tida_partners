import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_partners/controllers/SettingController.dart';
import 'package:tida_partners/utilss/theme.dart';
import 'package:tida_partners/web_content.dart';

import 'AppColors.dart';

class AppSetting extends StatelessWidget {
  AppSetting({Key? key}) : super(key: key);
  final _controller = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: setHeadlineMedium("Help"),
      ),
      body: Obx(() => _controller.loading.value
          ? Center(child: showLoader())
          : Container(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: _controller.dataList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        _controller.selectedVal(index);
                        Get.to(()=> WebContent());

                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: setMediumLabel(
                                _controller.dataList[index].title ?? ""),
                          ),
                          Divider()
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
