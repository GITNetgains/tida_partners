

import 'package:get/get.dart';
import 'package:tida_partners/controllers/AcademyController.dart';
import 'package:tida_partners/network/responses/academy_res.dart';

import '../network/ApiProvider.dart';
import '../network/responses/VenueListResponse.dart';

class SelectAcademyController extends GetxController{
  RxBool loading = false.obs;
  RxInt index = 0.obs;
  RxList academyList = [].obs;

  @override
  void onInit() {
    fetch();
    super.onInit();
  }


  Future<void> fetch() async {
    loading(true);
    AcademyResponse? vlist = await ApiProvider().fetchAllAcademies();
    if (vlist!.status!) {
      if (vlist.data != null) {
        academyList.assignAll(vlist.data!);
      }
      update();
      loading(false);
    }
  }


  selectVenue(int i) {

    Get.back(result:academyList[i]);
  }



}