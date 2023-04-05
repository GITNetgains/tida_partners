import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../AppColors.dart';
import '../utilss/theme.dart';
import 'facility_slots_vm.dart';

class FacilitySlotsView extends StatelessWidget {
  FacilitySlotsView({Key? key}) : super(key: key);
  final c = Get.put(FacilitySlotsVM());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: setHeadlineMedium(Get.arguments['Title']??"Select Slot", color: Colors.white),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(1, 1),
                      blurRadius: 15,
                      color: CupertinoColors.lightBackgroundGray)
                ]),
            child: Obx(() => TableCalendar(
                  firstDay: DateTime.now(),
                  focusedDay: c.selectedDateTime.value,
                  lastDay: DateTime(2100),
                  headerVisible: true,
                  currentDay: DateTime.now(),
                  calendarFormat: CalendarFormat.week,
                  selectedDayPredicate: (day) {
                    return isSameDay(c.selectedDateTime.value, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) async {
                    debugPrint("selectedDay $selectedDay");
                    c.selectedDateTime(selectedDay);
                    c.selectedSlot(-1);
                    c.selectedDate = DateFormat("yyyy-MM-dd")
                        .format(c.selectedDateTime.value);
                    await c.getFacilitySlots();
                    c.update();
                    c.refresh();
                  },
                )),
          ),
          Obx(() => c.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(color: Colors.red),
                )
              : c.slots!.isEmpty
                  ? Text("No Slots available for today.")
                  : Obx(() => Container(
                        height: MediaQuery.of(context).size.height - 350,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                              shrinkWrap: true,
                              //physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                              ),
                              itemCount: c.slots!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Obx(() => Container(
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          color: (c.slots![index]!
                                                          .slotBlockStatus
                                                          .toString() ==
                                                      "1" ||
                                                  c.slots![index]!
                                                          .slotBookingStatus
                                                          .toString() ==
                                                      "1")
                                              ? Colors.redAccent
                                              : c.selectedSlot.value == index
                                                  ? Colors.lightGreen
                                                  : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                                color: CupertinoColors
                                                    .extraLightBackgroundGray,
                                                blurRadius: 10,
                                                offset: Offset(1, 1))
                                          ]),
                                      child: Material(
                                        borderRadius: BorderRadius.circular(12),
                                        type: MaterialType.transparency,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          onTap:
                                              (c.slots![index]!.slotBlockStatus
                                                              .toString() ==
                                                          "1" ||
                                                      c.slots![index]!
                                                              .slotBookingStatus
                                                              .toString() ==
                                                          "1")
                                                  ? () {
                                                      Get.dialog(Center(
                                                        child: Wrap(
                                                          children: [
                                                            Material(
                                                              type: MaterialType
                                                                  .transparency,
                                                              child: Container(
                                                                  margin: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          24),
                                                                  padding: EdgeInsets.symmetric(
                                                                      vertical:
                                                                          16,
                                                                      horizontal:
                                                                          16),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              16),
                                                                      color: Colors
                                                                          .white),
                                                                  child: c.slots![index]!
                                                                              .slotBookingDetail !=
                                                                          null
                                                                      ? Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          children: [
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                setCardHeading("Booked by"),
                                                                              ],
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  setHeadlineMedium("Name", color: PRIMARY_COLOR),
                                                                                  setMediumLabel(c.slots![index]!.slotBookingDetail!.user!.name.toString(), color: PRIMARY_COLOR)
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            const Divider(),
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  setHeadlineMedium("Phone",color: PRIMARY_COLOR),
                                                                                  setMediumLabel(c.slots![index]!.slotBookingDetail!.user!.phone.toString(), color: PRIMARY_COLOR)
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            const Divider(),
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  setHeadlineMedium("email", color: PRIMARY_COLOR),
                                                                                  setMediumLabel(c.slots![index]!.slotBookingDetail!.user!.email.toString(), color: PRIMARY_COLOR)
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            const Divider(),
                                                                        /*    Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  setHeadlineMedium("Booking status", color: PRIMARY_COLOR),
                                                                                  setMediumLabel(c.slots![index]!.slotBookingDetail!.bookingStatus.toString(), color: PRIMARY_COLOR)
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            const Divider(),*/
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  setHeadlineMedium("Order Id", color: PRIMARY_COLOR),
                                                                                  setMediumLabel('#${c.slots![index]!.slotBookingDetail!.id!}', color: PRIMARY_COLOR)
                                                                                ],
                                                                              ),
                                                                            )
                                                                          ],
                                                                        )
                                                                      : Container(
                                                                          height:
                                                                              150,
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text("No Info available"),
                                                                          ),
                                                                        )),
                                                            )
                                                          ],
                                                        ),
                                                      ));
                                                    }
                                                  : () {
                                                      c.selectedSlot(index);
                                                      c.update();
                                                    },
                                          child: Container(
                                            //color: Colors.white,
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    setSmallLabel(getFormattedTime(
                                                            "${DateFormat("yyyy-MM-dd").format(c.selectedDateTime.value)} ${c.slots![index]!.slotStartTime!}")
                                                        .toString()),
                                                    getVerticalSpace(),
                                                    setSmallLabel(getFormattedTime(
                                                            "${DateFormat("yyyy-MM-dd").format(c.selectedDateTime.value)} ${c.slots![index]!.slotEndTime!}")
                                                        .toString()),
                                                    // Row(
                                                    //   mainAxisAlignment: MainAxisAlignment.center,
                                                    //   children: [
                                                    //     const Icon(
                                                    //       Icons.currency_rupee,
                                                    //       size: 18,
                                                    //     ),
                                                    //     setMediumLabel(
                                                    //         "${c.packages![index]!.price.toString()} Onwards",
                                                    //         color: Colors.grey),
                                                    //   ],
                                                    // ),
                                                    // getSecondaryButton("Book Now", () {
                                                    //   if (c.packages![index]!.price!.isNotEmpty) {
                                                    //     c.bookingAmt =
                                                    //         c.packages![index]!.price.toString();
                                                    //     c.packageId =
                                                    //         c.packages![index]!.id.toString();
                                                    //     c.getPaymentInfo(
                                                    //         c.packages![index]!.price.toString());
                                                    //   } else {
                                                    //     Get.snackbar("Can't Book", "No price from server");
                                                    //   }
                                                    // Get.toNamed(AppRoutes.facility,
                                                    //     parameters: {
                                                    //       "id": c.facilites![index]!.id!.toString(),
                                                    //       "amt": c.facilites![index]!.pricePerSlot.toString()
                                                    //     });
                                                    //}),
                                                    // getVerticalSpace(),
                                                    // Row(
                                                    //   mainAxisAlignment: MainAxisAlignment.center,
                                                    //   children: [
                                                    //     setMediumLabel("20% Off",
                                                    //         color: PRIMARY_COLOR,
                                                    //         decoration: TextDecoration.underline)
                                                    //   ],
                                                    // )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ));
                              }),
                        ),
                      ))),
          getVerticalSpace(),
          getVerticalSpace(),
          getVerticalSpace(),
          getVerticalSpace(),
          getVerticalSpace(),
          getVerticalSpace()
        ],
      ),
      floatingActionButton:Obx(() =>  c.selectedSlot.value != -1
          ? Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Row(
          children: [
            Obx(() =>  Expanded(
              child: c.isBooking.value
                  ? SizedBox(
                height: 50,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                ),
              )
                  :  getSecondaryButton("Book Slot", () {
                /* c.isBooking = true;
                            c.isLoading(true);
                            c.update();
                            c.bookFacilitySlot(
                                c.slots![c.selectedSlot.value]!.slotStartTime
                                    .toString(),
                                c.slots![c.selectedSlot.value]!.slotEndTime
                                    .toString());*/
                Get.dialog(Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Wrap(
                          children: [
                            Row(children: [
                              setMediumLabel("Coming Soon!"),

                            ],),

                            Padding(
                              padding: const EdgeInsets.only(top: 18.0, bottom: 18),
                              child: setMediumLabel("This feature will be available in the next release."),
                            ),
                            getSecondaryButton("Ok", () {

                              Get.back();

                            })

                          ],

                        ),
                      ),
                    ),
                  ),

                ), name: "sss");
              })
              ,
            ))
          ],
        ),
      )
          : Container()),
      // Center(
      //   child: c.bookingService!=null ? BookingCalendar(
      //   bookingService: c.bookingService!,
      //     convertStreamResultToDateTimeRanges: c.convertStreamResult,
      //     getBookingStream: c.getBookingStream,
      //     uploadBooking: c.uploadBooking,
      //     //pauseSlots: generatePauseSlots(),//pauseSlotText: 'LUNCH',  //hideBreakTime: false,
      //     loadingWidget: const Text('Fetching data...'),
      //     uploadingWidget: const CircularProgressIndicator(),
      //     locale: 'en',
      //     startingDayOfWeek: StartingDayOfWeek.monday,

      //     wholeDayIsBookedWidget:
      //         const Text('Sorry, for this day everything is booked'),
      //     //disabledDates: [DateTime(2023, 1, 20)],
      //     //disabledDays: [6, 7],
      //   ):Container(),
    );
  }
}
