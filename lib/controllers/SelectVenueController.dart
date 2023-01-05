

import 'package:get/get.dart';
import 'package:tida_partners/controllers/AcademyController.dart';

import '../network/ApiProvider.dart';
import '../network/responses/VenueListResponse.dart';

class SelectVenueController extends GetxController{
  RxBool loading = false.obs;
  RxInt index = 0.obs;
  RxList venueList = [].obs;
  final _controller = Get.put(AcademyController());

  @override
  void onInit() {
    fetch();
    super.onInit();
  }


  Future<void> fetch() async {
    loading(true);
    VenueList? vlist = await ApiProvider().fetchVenues();
    if (vlist!.status!) {
      if (vlist.data != null) {
        venueList.assignAll(vlist.data!);
      }
      update();
      loading(false);
    }
  }


  selectVenue(int i) {
    _controller.setSelectedVenue(venueList[i]);
    Get.back(result: true);
  }



}