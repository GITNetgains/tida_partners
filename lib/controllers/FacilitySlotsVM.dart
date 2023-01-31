import 'package:booking_calendar/booking_calendar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tida_partners/network/ApiProvider.dart';
import 'package:tida_partners/network/responses/SlotResponse.dart' as slot;

import '../utilss/SharedPref.dart';
import 'FacilityController.dart';


class FacilitySlotsVM extends GetxController {
  final _controller = Get.put(FacilityController());

  String? userId, userName, token;
  List<slot.Data>? slots = List.empty(growable: true);
  bool? isLoading = true, hasCallSupport = false;
  String? facilityId;
  final now = DateTime.now();
  BookingService? bookingService;
  List<DateTimeRange> converted = [];
  DateTime? bookingStart;
  DateTime? bookingEnd;
  String? selectedDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  DateTime? selectedDateTime = DateTime.now();
  String? amt = "0";
  String? slotId = "";

  @override
  void onInit() {
    super.onInit();

    init();
  }

  Future<void> init() async {
    await getFacilitySlots();
    isLoading = false;
    update();
  }

  Stream<dynamic>? getBookingStream(
      {required DateTime end, required DateTime start}) {
    debugPrint(
        "In getBooking Stream ${end.toIso8601String()}, ${start.toIso8601String()}");
    selectedDate = DateFormat("yyyy-MM-dd").format(start);
    selectedDateTime = start;
    getFacilitySlots();
    return Stream.value([]);
  }

  Future<dynamic> uploadBooking({required BookingService newBooking}) async {
    await Future.delayed(const Duration(seconds: 1));
    //2023-05-05T00:00:00
    String? startTime = newBooking.bookingStart.toString().substring(11, 19);
    String? endTime = newBooking.bookingEnd.toString().substring(11, 19);
    bookFacilitySlot(startTime, endTime);
    converted.clear();
    converted.add(DateTimeRange(
        start: newBooking.bookingStart, end: newBooking.bookingEnd));
    // print(
    //     '${newBooking.toJson()} has been uploaded ${newBooking.bookingStart.toString().substring(11, 19)}');
  }

  List<DateTimeRange> convertStreamResult({required dynamic streamResult}) {
    debugPrint("In convertStreamResult");
    if (slots!.isNotEmpty) {
      for (var i = 0; i < slots!.length; i++) {
        if (slots![i]!.slotBookingStatus == 1 ||
            slots![i]!.slotBlockStatus == 1) {
          DateTime start = DateTime.parse(
              "${DateFormat("yyyy-MM-dd").format(selectedDateTime!)} ${slots![i]!.slotStartTime}");
          DateTime end = DateTime.parse(
              "${DateFormat("yyyy-MM-dd").format(selectedDateTime!)} ${slots![i]!.slotEndTime}");
          converted.add(DateTimeRange(start: start, end: end));
        }
      }
    }

        return converted;
  }

  Future<void> getFacilitySlots() async {
    String token = Preferences.getToken();
    String user_id = Preferences.getUserId();

    Map<String, String> data = {
      "userid": user_id.toString(),
      "user_id": user_id.toString(),
      "token": token,
      "facility_id": _controller.dataResponse[_controller.selectedIndex.value].id.toString(),
      "date": selectedDate.toString()
    };
    debugPrint("v data $data");
    await ApiProvider().fetchSlots(data).then((response) {
      slot.FacilitySlotResponse? res =response;
      debugPrint("IN hEEre1");
      if (res?.status == true) {
        debugPrint("IN hEEre");
        slots!.clear();
        slots!.addAll(res!.data!);
        if (slots!.isNotEmpty) {
          bookingStart = DateTime.parse(
              "${DateFormat("yyyy-MM-dd").format(selectedDateTime!)} ${slots![0]!.slotStartTime}");
          bookingEnd = DateTime.parse(
              "${DateFormat("yyyy-MM-dd").format(selectedDateTime!)} ${slots![slots!.length - 1]!.slotEndTime}");
          bookingService = BookingService(
              serviceName: 'Slot Booking',
              serviceDuration: 30,
              bookingEnd: bookingEnd!,
              bookingStart: bookingStart!);
        }

        debugPrint(" slots ${slots!.length},  ");
        update();
      } else {
        debugPrint("IN hEEre3");
        //Get.snackbar("Server Msg", "${res.message}");
      }
    }).onError((error, stackTrace) {
      debugPrint("IN hEEr4 ${error.toString()}");
      Get.snackbar("Server Msg", error.toString());
    });
  }

  Future<void> bookFacilitySlot(startTime, endTime) async {
    var data = {
      "userid": userId.toString(),
      "token": token,
      "booking_user_id": "1",
      "facility_id":  facilityId.toString(),
      "date": selectedDate,
      "start_time": startTime,
      "end_time": endTime
    };
 /*   debugPrint("v1 data $data");
    await ApiService.bookFacilitySlots(data).then((response) {
      debugPrint("v1 data res $response");
      book.SlotBookingResponseModel? res =
      book.slotBookingResponseModelFromJson(response);
      debugPrint("IN hEEre1");
      if (res.status!) {
        debugPrint("IN hEEre");
        slotId = res.data!.isNotEmpty ? res.data![0].id.toString() : null;
        getPaymentInfo();
        update();
      } else {
        debugPrint("IN hEEre3");
        //Get.snackbar("Server Msg", "${res.message}");
      }
    }).onError((error, stackTrace) {
      debugPrint("IN hEEr4 ${error.toString()}");
      Get.snackbar("Server Msg", error.toString());
    });*/
  }

  @override
  void dispose() {
    super.dispose();

  }
}
