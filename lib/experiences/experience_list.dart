import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../AppColors.dart';
import '../controllers/ExperienceController.dart';
import '../controllers/tournament_controller.dart';
import '../network/responses/TournamentListResponse.dart';
import '../tournaments/add_tournament.dart';
import '../utilss/size_config.dart';
import '../utilss/theme.dart';
import 'add_experiences.dart';

class ExperienceList extends StatelessWidget {
  ExperienceList({Key? key}) : super(key: key);
  final _controller = Get.put(ExperienceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: setHeadlineMedium("Experiences"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _controller.isEdit(false);
          Get.to(() => AddExperiences());
        },
        backgroundColor: PRIMARY_COLOR,
        child: Icon(Icons.add),
      ),
      body: Obx(() => _controller.isLoading.value
          ? showLoader()
          : _controller.data.isNotEmpty
              ? ListView.builder(
                  itemCount: _controller.data.length,
                  itemBuilder: (context, index) {
                    var item = _controller.data[index];
                    return Card(
                      child: Row(
                        children: [
                          SizedBox(
                            width: SizeConfig.screenWidth / 3,
                            child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    topLeft: Radius.circular(5)),
                                child: Container(
                                  child: FadeInImage(
                                    image: NetworkImage('${item}'),
                                    height: 130,
                                    fit: BoxFit.cover,
                                    placeholderFit: BoxFit.fitWidth,
                                    placeholder: const AssetImage(
                                      "assets/no_image.png",
                                    ),
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
                                      return Image.asset('assets/no_image.png',
                                          fit: BoxFit.fitWidth);
                                    },
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: SizeConfig.screenWidth / 1.9,
                              child: SizedBox(
                                child: Flexible(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            setHeadlineLarge("Experience Name name name"),
                                            setSmallLabel("text")
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                )
              : Center(
                  child: Text("Please click on + icon to add experience."))),
    );
  }
}
