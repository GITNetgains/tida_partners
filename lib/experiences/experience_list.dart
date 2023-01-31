import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../AppColors.dart';
import '../controllers/ExperienceController.dart';
import '../utilss/size_config.dart';
import '../utilss/theme.dart';
import 'add_experiences.dart';

class ExperienceList extends StatelessWidget {
  ExperienceList({Key? key}) : super(key: key);
  final _controller = Get.put(ExperienceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),

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
                    return InkWell(
                      onTap: () {
                        _controller.isEdit(true);
                        _controller.selectedIndex(index);
                        _controller.preFillData();
                        Get.to(() => AddExperiences());
                      },
                      child: Card(
                        elevation: 5,
                        child: Row(
                          children: [
                            SizedBox(
                              width: SizeConfig.screenWidth / 3,
                              child: getImageWidget(item.image ?? ""),
                            ),
                            Flexible(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: setHeadlineLarge((item.title ?? "").capitalizeFirst!),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: setSmallLabel((item.description ?? "").capitalizeFirst!),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Text("Please click on + icon to add experience."))),
    );
  }
}
