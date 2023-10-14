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
                    // const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(0),
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
    String displaytiming = "";
    String displayaddress = " ";
    //type: 1-venue/facility,2-academy/session,3-tournament,4-experience
    switch (_c.getSelectedOrder().type) {
      case "1":
        displaytiming =
            "${_c.getSelectedOrder().facilityBooking?.date}  ${_c.getSelectedOrder().facilityBooking!.slotStartTime ?? ""} - ${_c.getSelectedOrder().facilityBooking!.slotEndTime ?? ""} ";
        displayName = _c.getSelectedOrder().venu_name ?? "Facility";
        displayaddress = _c.getSelectedOrder().facilityaddress.toString() ?? " ";
        break;
      case "3":
        displayName = _c.getSelectedOrder().tournament?.title ?? "Tournament";
        // displayaddress = _c.getSelectedOrder().facilityaddress.toString() ?? " ";
        break;
      case "2":
        displayName = _c.getSelectedOrder().academy?.name ?? "Academy";
        displayaddress = _c.getSelectedOrder().academy!.address.toString() ?? " ";
        break;
      case "4":
        displayName = _c.getSelectedOrder().experience?.title ?? "Experience";
        displayaddress = _c.getSelectedOrder().experience!.address.toString() ?? " ";
        break;
      default:
        displayName = "-";
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
           const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              setHeadlineMedium("Service Name", color: Colors.black),
              Container(
                  width: 150,
                  child: setHeadlineMedium('${(displayName)}',
                      color: PRIMARY_COLOR, textAlign: TextAlign.right)),
            ],
          ),
          displaytiming == "" ? Container() : const Divider(),
          displaytiming == ""
              ? Container()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    setHeadlineMedium("Slot Timing", color: Colors.black),
                    Container(
                        width: 180,
                        child: setHeadlineMedium(
                          '${(displaytiming)}',
                          color: PRIMARY_COLOR,
                          textAlign: TextAlign.right
                        )),
                  ],
                ),
          Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical:8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              setHeadlineMedium("Service Address", color: Colors.black),
              Container(
                  width: 150,
                  child: setHeadlineMedium('${(displayaddress)}',
                      color: PRIMARY_COLOR,textAlign: TextAlign.right )),
            ],
          ),
        ),
        ],
      ),
    );
  }
}
