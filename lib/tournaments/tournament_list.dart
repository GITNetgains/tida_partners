import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_partners/tournaments/add_tournament.dart';

import '../AppColors.dart';
import '../controllers/tournament_controller.dart';
import '../network/responses/TournamentListResponse.dart';
import '../utilss/theme.dart';

class TournamentList extends StatelessWidget {
  TournamentList({Key? key}) : super(key: key);
  final _controller = Get.put(TournamentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: setHeadlineMedium("Tournaments"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _controller.isEdit(false);
          _controller.selectedSponsor.clear();
          _controller.selectedIndex(-1);
          _controller.preFillData();
          await Get.to(() => AddTournament());
          _controller.fetchTournament();
        },
        backgroundColor: PRIMARY_COLOR,
        child: Icon(Icons.add),
      ),
      body: Obx(() => _controller.isLoading.value
          ? showLoader()
          : _controller.data.isNotEmpty?ListView.builder(
        itemCount: _controller.data.length,
        itemBuilder: (context, index) {
          Data item = _controller.data[index];
          return Container(
            margin: EdgeInsets.only(
              bottom: (index ==_controller.data.length-1  &&_controller.data.length != 1)?100:0

            ),
            child: Card(
              elevation: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(5),
                          topLeft: Radius.circular(5)),
                      child: getImageWidget(item.image??"-")),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  setHeadlineMedium(item.title ?? "N/A",
                                      color: Colors.black),
                                  setMediumLabel('₹${item.price}' ?? "N/A",
                                      color: Colors.grey),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                _controller.isEdit(true);
                                _controller.selectedIndex(index);
                                _controller.selectedSponsor.clear();
                                _controller.preFillData();

                                await Get.to(() => AddTournament());
                                _controller.isEdit(false);
                                _controller.fetchTournament();
                              },
                              child: const CircleAvatar(
                                child: Icon(Icons.edit),
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ):Center(child: setSmallLabel("Click on + icon to add Tournament. "),)),
    );
  }
}
