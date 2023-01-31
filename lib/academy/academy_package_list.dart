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
          _controller.setAcademyData(reset: true);

          openAddPack();

        },
        backgroundColor: PRIMARY_COLOR,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: setHeadlineMedium("Academy Packages"),
      ),
      body: Obx(() => _controller.loading.value?showLoader(): _controller.packageList.isNotEmpty?ListView.builder(
        itemCount: _controller.packageList.length,

        itemBuilder: (context, index) {
          return  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                InkWell(
                  onTap: (){
                    _controller.isEditPackage(true);
                    _controller.selectedPackage(index);
                    _controller.setAcademyData(reset: false);

                    openAddPack();


                  },
                  child: ListTile(
                    leading: CircleAvatar(child: Icon(Icons.star, color: Colors.white,), backgroundColor: PRIMARY_COLOR,),
                    subtitle: setMediumLabel('₹${(_controller.packageList[index].price??"-").capitalizeFirst!}'),
                    title: setMediumLabel((_controller.packageList[index].title??"-").capitalizeFirst!),

                  ),
                ),
                Divider()
              ],
            ),
          );
        },
      ):Center(child: setMediumLabel("Click + icon to add new package"))),

    );
  }

  void openAddPack() async {


    await Get.to(()=>  AddPackage());
    _controller.fetchPackages();

  }
}
