import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_partners/AppColors.dart';
import 'package:tida_partners/controllers/AcademyController.dart';

import '../controllers/VenueDetailsController.dart';
import '../utilss/theme.dart';

class SelectSportsAcademy extends StatefulWidget {
  const SelectSportsAcademy({super.key});

  @override
  _SelectSportsAcademyState createState() => _SelectSportsAcademyState();
}

class _SelectSportsAcademyState extends State<SelectSportsAcademy> {
  final _controller = Get.put(AcademyController());
  bool isSelectionMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Item'),
        backgroundColor: PRIMARY_COLOR,
        actions: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: setMediumLabel("Done", color: Colors.white)),
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemBuilder: (builder, index) {
          final data = _controller.sportsListInString[index].toString();

          bool isSelected = _controller.selectedSport.contains(data);
          return Column(
            children: [
              ListTile(
                onTap: () => onTap(isSelected, index),
                title: Text(data.toUpperCase()),
                leading: _buildSelectIcon(isSelected, data),
              ),
              Divider(
                color: Colors.grey,
              )
            ],
          );
        },
        itemCount: _controller.sportsListInString.length,
      ),
    );
  }

  void onTap(bool isSelected, int index) {
    setState(() {
      _controller.selectSportItem(_controller.sportsListInString[index]);
    });
  }

  Widget _buildSelectIcon(bool isSelected, String data) {
    return Icon(
      isSelected ? Icons.check_box : Icons.check_box_outline_blank,
      color: PRIMARY_COLOR,
    );
  }
}
