import 'package:booking_calendar/booking_calendar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../controllers/FacilityController.dart';
import '../network/ApiProvider.dart';
import '../utilss/SharedPref.dart';
import 'facility_booking_model.dart';
import 'fetch_facility_slots_model.dart' as slot;
import 'fetch_facility_slots_model.dart';

class FacilitySlotsVM extends GetxController {

  String? userId, userName, token;
  RxList<slot.Datum?>? slots = <slot.Datum?>[].obs;
  bool hasCallSupport = false;
  RxBool isLoading = true.obs;
  String? facilityId;
  final now = DateTime.now();
  BookingService? bookingService;
  List<DateTimeRange> converted = [];
  DateTime? bookingStart;
  DateTime? bookingEnd;
  String? selectedDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  Rx<DateTime> selectedDateTime = DateTime.now().obs;
  String? amt = "0";
  String? slotId = "";
  RxInt selectedSlot = (-1).obs;
  RxBool isBooking  = false.obs;

  bool isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) {
      return false;
    }

    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  void onInit() {
    super.onInit();

    init();
  }

  Future<void> init() async {
    initializeDateFormatting();

    await getFacilitySlots();
    isLoading(false);
    update();
  }

  Stream<dynamic>? getBookingStream(
      {required DateTime end, required DateTime start}) {
    debugPrint(
        "In getBooking Stream ${end.toIso8601String()}, ${start.toIso8601String()}");
    selectedDate = DateFormat("yyyy-MM-dd").format(start);
    selectedDateTime(start);
    getFacilitySlots();
    return Stream.value([]);
  }

  Future<dynamic> uploadBooking({required BookingService newBooking}) async {
    //await Future.delayed(const Duration(seconds: 1));
    //2023-05-05T00:00:00
    String? startTime =
        newBooking.bookingStart.toString(); //.substring(11, 19);
    String? endTime = newBooking.bookingEnd.toString(); //.substring(11, 19);
    bookFacilitySlot(startTime, endTime);
    // converted.clear();
    // converted.add(DateTimeRange(
    //     start: newBooking.bookingStart, end: newBooking.bookingEnd));
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
              "${DateFormat("yyyy-MM-dd").format(selectedDateTime.value)} ${slots![i]!.slotStartTime}");
          DateTime end = DateTime.parse(
              "${DateFormat("yyyy-MM-dd").format(selectedDateTime.value)} ${slots![i]!.slotEndTime}");
          converted.add(DateTimeRange(start: start, end: end));
        }
      }
    }

    ///here you can parse the streamresult and convert to [List<DateTimeRange>]
    ///take care this is only mock, so if you add today as disabledDays it will still be visible on the first load
    ///disabledDays will properly work with real data
    // DateTime first = now;
    // DateTime tomorrow = now.add(Duration(days: 1));
    // DateTime second = now.add(const Duration(minutes: 55));
    // DateTime third = now.subtract(const Duration(minutes: 240));
    // DateTime fourth = now.subtract(const Duration(minutes: 500));
    // converted.add(
    //     DateTimeRange(start: first, end: now.add(const Duration(minutes: 30))));
    // converted.add(DateTimeRange(
    //     start: second, end: second.add(const Duration(minutes: 23))));
    // converted.add(DateTimeRange(
    //     start: third, end: third.add(const Duration(minutes: 15))));
    // converted.add(DateTimeRange(
    //     start: fourth, end: fourth.add(const Duration(minutes: 50))));

    // //book whole day example
    // converted.add(DateTimeRange(
    //     start: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 5, 0),
    //     end: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 23, 0)));
    return converted;
  }

  Future<void> getFacilitySlots() async {
    String token = Preferences.getToken();
    String user_id = Preferences.getUserId();

    Map<String, String> data = {
      "userid": user_id.toString(),
      "token": token,
      "facility_id": "1",
      "date": selectedDate.toString()
    };
    debugPrint("v data $data");
    isLoading(true);
    await ApiProvider().fetchSlots(data).then((response) {
      FetchSlotsResponseModel? res =response;
      debugPrint("IN hEEre1");
      if (res?.status == true) {
        debugPrint("IN hEEre");

        slots!.addAll(res!.data!);
        if (slots!.isNotEmpty) {
          bookingStart = DateTime.parse(
              "${DateFormat("yyyy-MM-dd").format(selectedDateTime.value)} ${slots![0]!.slotStartTime}");
          bookingEnd = DateTime.parse(
              "${DateFormat("yyyy-MM-dd").format(selectedDateTime.value)} ${slots![slots!.length - 1]!.slotEndTime}");
          bookingService = BookingService(
              serviceName: 'Slot Booking',
              serviceDuration: 60,
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
    isLoading(false);
    update();
    refresh();
  }

  Future<void> bookFacilitySlot(startTime, endTime) async {
   /* var data = {
      "userid": userId.toString(),
      "token": token,
      "booking_user_id": userId.toString(),
      "facility_id": facilityId.toString(),
      "date": selectedDate,
      "start_time": startTime,
      "end_time": endTime
    };
    debugPrint("v1 data $data");
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
        isBooking = false;
        isLoading = false;
        update();
        //Get.snackbar("Server Msg", "${res.message}");
      }
    }).onError((error, stackTrace) {
      debugPrint("IN hEEr4 ${error.toString()}");
      Get.snackbar("Server Msg", error.toString());
      isBooking = false;
      isLoading = false;
      update();
    });*/
  }


  @override
  void dispose() {
    super.dispose();

  }
}
