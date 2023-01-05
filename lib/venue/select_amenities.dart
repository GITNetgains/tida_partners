import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_partners/AppColors.dart';
import 'package:tida_partners/utilss/theme.dart';

import '../controllers/VenueDetailsController.dart';
class SelectAmenities extends StatefulWidget {
  const SelectAmenities({super.key});

  @override
  _SelectAmenitiesState createState() => _SelectAmenitiesState();
}
class _SelectAmenitiesState extends State<SelectAmenities> {
  final _controller = Get.put(VenueDetailsController());
  bool isSelectionMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Item'),
        backgroundColor: PRIMARY_COLOR,
        actions: [InkWell(
          onTap: (){
            Get.back();

          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: setMediumLabel("Done", color: Colors.white)),
          ),
        )],
      ),
      body: ListView.builder(
        itemBuilder: (builder, index) {
          final data = _controller.amenetiesListInString[index].toString();

          bool isSelected = _controller.tags.contains(data);
          return Column(
            children: [
              ListTile(
                onTap: () => onTap(isSelected, index),
                title: Text(data.toUpperCase()),
                leading: _buildSelectIcon(isSelected, data),
              ),
              Divider(color: Colors.grey,)
            ],
          );
        },
        itemCount: _controller.amenetiesListInString.length,
      ),
    );
  }
  void onTap(bool isSelected, int index) {
      setState(() {
         _controller.selectAmenities(_controller.amenetiesListInString[index]);
      });

  }

  Widget _buildSelectIcon(bool isSelected, String data) {
      return Icon(
        isSelected ? Icons.check_box : Icons.check_box_outline_blank,
        color: PRIMARY_COLOR,
      );

  }

}