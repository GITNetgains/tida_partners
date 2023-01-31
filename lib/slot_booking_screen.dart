import 'package:booking_calendar/booking_calendar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_partners/controllers/FacilitySlotsVM.dart';
import 'package:tida_partners/utilss/theme.dart';

import 'AppColors.dart';

class SlotBookingScreen extends StatelessWidget {
    SlotBookingScreen({Key? key}) : super(key: key);
    final c = Get.put(FacilitySlotsVM());

  @override
  Widget build(BuildContext context) {

    return Scaffold(

    appBar: AppBar(
    backgroundColor: PRIMARY_COLOR,
    title: setHeadlineMedium("Bookings"),
    ),
      body:   Obx(() =>c.isLoading.value?showLoader(): Center(
        child: c.bookingService!=null ? BookingCalendar(
          bookingService: c.bookingService!,
          convertStreamResultToDateTimeRanges: c.convertStreamResult,
          getBookingStream: c.getBookingStream,
          uploadBooking: c.uploadBooking,

          //pauseSlots: generatePauseSlots(),//pauseSlotText: 'LUNCH',  //hideBreakTime: false,
          loadingWidget: const Text('Fetching data...'),
          uploadingWidget: const CircularProgressIndicator(),
          locale: 'en',
          startingDayOfWeek: StartingDayOfWeek.monday,
          //disabledDates: [DateTime(2023, 1, 20)],
          //disabledDays: [6, 7],
        ):Container(),
      )),

    );
  }
}
