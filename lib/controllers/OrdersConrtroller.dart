import 'package:get/get.dart';
import 'package:tida_partners/network/responses/AllOrdersResponse.dart';

import '../network/ApiProvider.dart';

class OrdersController extends GetxController {
  RxBool loading = false.obs;
  RxList<Data> orderList = <Data>[].obs;
  RxInt index = (-1).obs;

  @override
  void onInit() {
    fetchOrders();
    super.onInit();
  }

  void fetchOrders() async {
    loading(true);
    orderList.clear();
    AllOrdersResponse? response = await ApiProvider().fetchOrders();
    if (response != null) {
      if (response.data != null) {
        orderList.assignAll(response.data!);
        orderList = orderList.reversed.toList().obs;
      }
    }

    loading(false);
  }

  Data getSelectedOrder() {
    return orderList[index.value];
  }
}
