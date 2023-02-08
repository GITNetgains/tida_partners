import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_partners/AppColors.dart';
import 'package:tida_partners/controllers/tournament_controller.dart';

import '../controllers/VenueDetailsController.dart';
import '../utilss/theme.dart';

class SponsorList extends StatefulWidget {
  const SponsorList({super.key});

  @override
  _SponsorListState createState() => _SponsorListState();
}

class _SponsorListState extends State<SponsorList> {
  final _controller = Get.put(TournamentController());
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
          final data = _controller.selectedSponsorInList[index].toString();

          bool isSelected = _controller.selectedSponsor.contains(data);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                onTap: () => onTap(isSelected, index),
                title: Text(data.toUpperCase()),
                leading: _buildSelectIcon(isSelected, data),
              ),
              const Divider(
                color: Colors.grey,
              )
            ],
          );
        },
        itemCount: _controller.selectedSponsorInList.length,
      ),
    );
  }

  void onTap(bool isSelected, int index) {
    setState(() {
      _controller.selectSportItem(_controller.selectedSponsorInList[index]);
    });
  }

  Widget _buildSelectIcon(bool isSelected, String data) {
    return Icon(
      isSelected ? Icons.check_box : Icons.check_box_outline_blank,
      color: PRIMARY_COLOR,
    );
  }
}
