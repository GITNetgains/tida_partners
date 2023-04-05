import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_partners/order_details.dart';
import 'package:tida_partners/utilss/theme.dart';

import 'AppColors.dart';
import 'controllers/OrdersConrtroller.dart';
import 'network/responses/AllOrdersResponse.dart';

class Bookings extends StatelessWidget {
  Bookings({Key? key}) : super(key: key);
  final _c = Get.put(OrdersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: PRIMARY_COLOR,
          title: setHeadlineLarge("Bookings", color: Colors.white),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            return _c.fetchOrders();
          },
          child: Container(
            child: Obx(() => _c.loading.value
                ? showLoader()
                : (_c.orderList.isNotEmpty
                    ? ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: _c.orderList.length,
                        itemBuilder: (BuildContext context, int index) {
                          Data d = _c.orderList[index];
                          return InkWell(
                            onTap: () {
                              _c.index(index);
                              Get.to(() => OrderDetails());
                            },
                            child: Card(
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    setHeadlineLarge('#${d.id ?? ""}',
                                        color: PRIMARY_COLOR),
                                    _getInfo("Customer Name",
                                        '${d.user?.name ?? ""}'),
                                    _getInfo("Order Type",
                                        '${_getOrderType(d.type ?? "")}'),
                                    _getInfo(
                                        "Order Status",
                                        (d.status == "1"
                                            ? "Completed"
                                            : "Pending")),
                                    _getInfo(
                                        "Amount",
                                        (d.amount!=null )?"₹${ d.amount}":"-"),
                                    _getInfo("Order Date & Time",
                                        getFormattedDate(d.orderDate ?? "")),
                                    _getInfo(
                                        "",
                                        getFormattedTime(d.orderDate ?? "")
                                            .toUpperCase()),
                                  ],
                                ),
                              ),
                            ),
                          );
                        })
                    : Center(
                        child: setMediumLabel(
                            "No order available. Please check back later."),
                      ))),
          ),
        ));
  }

  _getOrderType(String type) {
//type: 1-venue/facility,2-academy/session,3-tournament,4-experience
    switch (type) {
      case "1":
        return "Facility Slot";

      case "2":
        return "Academy Session";
      case "3":
        return "Tournament";
      case "4":
        return "Experience";

      default:
        return "N/A";
    }
  }

  _getInfo(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          setHeadlineMedium(title, color: Colors.black),
          setHeadlineMedium(value.capitalizeFirst!, color: PRIMARY_COLOR),
        ],
      ),
    );
  }
}
