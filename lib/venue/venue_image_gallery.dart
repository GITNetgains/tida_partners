import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_partners/controllers/HomeScreenController.dart';

import '../AppColors.dart';
import '../utilss/theme.dart';

class VenueImageGallery extends StatelessWidget {
    VenueImageGallery({Key? key}) : super(key: key);
  final _controller = Get.put(HomeScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:   FloatingActionButton(
        onPressed: (){
          _controller.selectImage();

        },
        backgroundColor: PRIMARY_COLOR,
        child: Icon(Icons.add),

      ),
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: setHeadlineMedium("Gallery"),
      ),
      body:Obx(() => _controller.loading.value?showLoader(): Padding(
        padding: const EdgeInsets.all(8.0),
        child:Obx(() =>  _controller.imageList.isEmpty?Center(child: setMediumLabel("Please add images by clicking on + Icon."),):GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16),
            children: getList())),
      )),
    );
  }

  List<Widget>getList(){
    List<Widget> items =[];
    if(_controller.imageList.isNotEmpty){
      for(int i =0; i <_controller.imageList.length; i++){
        items.add(Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child:Image.network('https://tidasports.com/secure/uploads/tbl_upload/${_controller.imageList[i]?.image}'),
            ),
              Positioned(
              right: 1,
              top: 1,
              child: InkWell(
                onTap: (){
                  _controller.deleteMedia(i);

                },
                child: Padding(
                  padding: EdgeInsets.only(right: 2, top: 2),
                  child: CircleAvatar(
                    backgroundColor: PRIMARY_COLOR,
                    radius: 12,
                    child:  Text("X", style: TextStyle(color: Colors.white),),

                  ),
                ),
              ),
            )

          ],

        ),);
      }

    }

    return items;

  }

}
