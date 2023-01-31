import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_partners/utilss/theme.dart';

import 'AppColors.dart';
import 'controllers/OrdersConrtroller.dart';

class OrderDetails extends StatelessWidget {
  OrderDetails({Key? key}) : super(key: key);
  final _c = Get.put(OrdersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: PRIMARY_COLOR,
          title: setHeadlineLarge(
              "Booking Details #${_c.getSelectedOrder().id}",
              color: Colors.white),
        ),
        body: Obx(
          () => _c.loading.value
              ? showLoader()
              : ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          setHeadlineMedium("Name", color: Colors.black),
                          setHeadlineMedium(
                              '${_c.getSelectedOrder().user?.name ?? ""}',
                              color: PRIMARY_COLOR),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          setHeadlineMedium("Phone", color: Colors.black),
                          setHeadlineMedium(
                              '${_c.getSelectedOrder().user?.phone ?? ""}',
                              color: PRIMARY_COLOR),
                        ],
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          setHeadlineMedium("Order Id", color: Colors.black),
                          setHeadlineMedium('#${_c.getSelectedOrder().id}',
                              color: PRIMARY_COLOR),
                        ],
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          setHeadlineMedium("Order Status",
                              color: Colors.black),
                          setHeadlineMedium(
                              '${(_c.getSelectedOrder().status == "1" ? "Completed" : "Pending")}',
                              color: PRIMARY_COLOR),
                        ],
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          setHeadlineMedium("Amount Paid", color: Colors.black),
                          setHeadlineMedium(_c.getSelectedOrder().amount ?? "-",
                              color: PRIMARY_COLOR),
                        ],
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          setHeadlineMedium("Order Type", color: Colors.black),
                          setHeadlineMedium(
                              '${(_getOrderType(_c.getSelectedOrder().type ?? ""))}',
                              color: PRIMARY_COLOR),
                        ],
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _getBookingWidget(),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          setHeadlineMedium("Transaction Id",
                              color: Colors.black),
                          setHeadlineMedium(
                              '#${_c.getSelectedOrder().transactionId.toString()}',
                              color: PRIMARY_COLOR),
                        ],
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          setHeadlineMedium("Transaction Type",
                              color: Colors.black),
                          setHeadlineMedium(
                              '${(_c.getSelectedOrder().type == "2") ? "Online" : "Offline"}',
                              color: PRIMARY_COLOR),
                        ],
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          setHeadlineMedium("Booking date",
                              color: Colors.black),
                          setHeadlineMedium(
                              getFormattedDateTime(
                                  _c.getSelectedOrder().orderDate ?? ""),
                              color: PRIMARY_COLOR),
                        ],
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          setHeadlineMedium("Order placed",
                              color: Colors.black),
                          setHeadlineMedium(
                              getFormattedDateTime(
                                  _c.getSelectedOrder().createdAt ?? ""),
                              color: PRIMARY_COLOR),
                        ],
                      ),
                    ),
                    const Divider(),
                  ],
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

  _getBookingWidget() {
    String displayName = "";

    //type: 1-venue/facility,2-academy/session,3-tournament,4-experience
    switch (_c.getSelectedOrder().type) {
      case "1":
        displayName = _c.getSelectedOrder().facility?.title ?? "-";
        break;
      case "2":
        displayName = _c.getSelectedOrder().tournament?.title ?? "-";
        break;
      case "3":
        displayName = _c.getSelectedOrder().academy?.name ?? "-";
        break;
      case "4":
        displayName = _c.getSelectedOrder().experience?.title ?? "-";
        break;
      default:
        displayName = "-";
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        setHeadlineMedium("Service Name", color: Colors.black),
        setHeadlineMedium('${(displayName)}', color: PRIMARY_COLOR),
      ],
    );
  }
}
