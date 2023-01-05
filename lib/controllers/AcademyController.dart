import 'package:get/get.dart';
import 'package:tida_partners/network/ApiProvider.dart';
import 'package:tida_partners/network/responses/VenueListResponse.dart' as v;
import 'package:tida_partners/network/responses/academy_res.dart';

class AcademyController extends GetxController {
  late RxList<Data> dataList;
  RxBool loading = false.obs;
    Rx<v.Data?> vData = null.obs;

  @override
  void onInit() {
    getAllAcademies();
    super.onInit();
  }

  void getAllAcademies() async {
    loading(true);
    AcademyResponse? response = await ApiProvider().fetchAllAcademies();
    if (response != null) {
      if (response.status == true) {
        dataList = response.data!.obs;
      }
    }
    loading(false);
  }

  void setSelectedVenue(v.Data data) {
    vData = data.obs;
    update();
  }
}
