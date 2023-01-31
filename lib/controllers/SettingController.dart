import 'package:get/get.dart';
import 'package:tida_partners/network/responses/CMSresponse.dart';

import '../network/ApiProvider.dart';

class SettingController extends GetxController {


  @override
  void onInit() {
    fetch();
    super.onInit();
  }

  RxString title = "".obs;
  RxInt selectedVal = (-1).obs;
  RxString content = ''.obs;
  RxBool loading = false.obs;
  RxList<Data> dataList = <Data>[].obs;




  Future<void> fetch() async {
    loading(true);
    CmsResponse? vlist = await ApiProvider().fetchCMS();
    if (vlist != null) {
      if (vlist!.status!) {
        if (vlist.data != null) {
          dataList.assignAll(vlist.data!);
        }
      }
    }
    loading(false);
  }
}
