import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:tida_partners/utilss/theme.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:html/dom.dart' as dom;
import 'AppColors.dart';
import 'controllers/SettingController.dart';

class WebContent extends StatelessWidget {
    WebContent({Key? key}) : super(key: key);
    final _controller = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: setHeadlineMedium("Settings"),
      ),
      body: Obx(() => ListView(
        children: [Html(
          data: _controller.dataList[_controller.selectedVal.value].description??"",
        )],

      )),

    );
  }
}
