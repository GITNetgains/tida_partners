import 'package:get/get.dart';
import 'package:tida_partners/network/responses/AllOrdersResponse.dart';

import '../network/ApiProvider.dart';

class OrdersController extends GetxController {
  RxBool loading = false.obs;
  RxList<Data> orderList = <Data>[].obs;
  RxInt index = (-1).obs;
  RxString selectedBookingId = "".obs;

  @override
  Future<void> onInit() async {
    await fetchOrders();
    if (selectedBookingId.value != "") {
      for (int i = 0; i < orderList.length; i++) {
        if (orderList[i].id == selectedBookingId.value) {
          index(i);
        }
      }
    }
    super.onInit();
  }

  Future<void> fetchOrders() async {
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
