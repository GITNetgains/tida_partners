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
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: setHeadlineMedium("Tournaments"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _controller.isEdit(false);
          Get.to(() => AddTournament());
        },
        backgroundColor: PRIMARY_COLOR,
        child: Icon(Icons.add),
      ),
      body: Obx(() => _controller.isLoading.value
          ? showLoader()
          : ListView.builder(
              itemCount: _controller.data.length,
              itemBuilder: (context, index) {
                Data item = _controller.data[index];
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
                              image: NetworkImage('${item.image}'),
                              height: 130,
                              fit: BoxFit.cover,
                              placeholderFit: BoxFit.fitWidth,
                              placeholder: const AssetImage(
                                "assets/no_image.png",
                              ),
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset('assets/no_image.png',
                                    fit: BoxFit.fitWidth);
                              },
                            ),
                          )),
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
                                    _controller.preFillData();
                                    await Get.to(() => AddTournament());
                                    _controller.isEdit(false);
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
                );
              },
            )),
    );
  }
}
