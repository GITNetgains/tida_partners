import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_partners/academy/add_package.dart';

import '../AppColors.dart';
import '../controllers/AcademyController.dart';
import '../utilss/theme.dart';

class AcademyPackageList extends StatelessWidget {
    AcademyPackageList({Key? key}) : super(key: key);
  final _controller = Get.put(AcademyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _controller.isEditPackage(false);
          Get.to(()=>  AddPackage());

        },
        backgroundColor: PRIMARY_COLOR,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: setHeadlineMedium("Academy Packages"),
      ),
      body: ListView.builder(
        itemCount: 10,

        itemBuilder: (context, index) {
          return  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                InkWell(
                  onTap: (){
                    _controller.isEditPackage(true);
                    Get.to(()=>  AddPackage());

                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children:   [
                          CircleAvatar(
                            backgroundColor: PRIMARY_COLOR,
                            child: Icon(
                                Icons.star, color: Colors.white,
                            ),

                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: setMediumLabel("text".capitalizeFirst!),
                          )

                        ],

                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.edit),
                      )

                    ],

                  ),
                ),
                Divider()
              ],
            ),
          );
        },
      ),

    );
  }
}
