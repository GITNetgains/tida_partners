import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_partners/AppUtils.dart';

import '../network/ApiProvider.dart';
import '../network/responses/facilityListResponse.dart' as aa;
import 'HomeScreenController.dart';

class FacilityController extends GetxController {
  final _homeController = Get.put(HomeScreenController());

  final titleController = TextEditingController();
  final inventoryCountController = TextEditingController();
  final minPlayerCtrl = TextEditingController();
  final maxPlayerCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final openingCtrl = TextEditingController();
  final closingCtrl = TextEditingController();
  final slotLHourCtrl = TextEditingController();
  final slotLMinCtrl = TextEditingController();
  final freqCtrl = TextEditingController();
  RxBool status = true.obs;
  RxBool isLoading = false.obs;
  RxBool is24hrs = false.obs;
  RxList<aa.Data> dataResponse = <aa.Data>[].obs;
  RxBool isEdit = false.obs;
  RxInt selectedIndex = (-1).obs;

  @override
  void onInit() {
    fetchFacilities();
    super.onInit();
  }

  saveFacility(Map<String, String>? datas, bool edit) async {
    debugPrint("${datas}-----------------");
    if(edit == true)
    {
    if ((datas != null && datas != {})) {
      debugPrint("${datas.toString()}-----------------");
      print(datas["title"]);
      if (titleController.text.isEmpty &&
          (datas["title"] == null || datas["title"] == "")) {
        AppUtills.showSnackBar("Required", "Title is required", isError: true);
      } /*else if (inventoryCountController.text.isEmpty) {
      AppUtills.showSnackBar(
          "Required", "Please enter valid number for inventories",
          isError: true);
      } else if (minPlayerCtrl.text.isEmpty) {
      AppUtills.showSnackBar(
          "Required", "Please enter valid number for minimum player",
          isError: true);
      } else if (maxPlayerCtrl.text.isEmpty) {
      AppUtills.showSnackBar(
          "Required", "Please enter valid number for maximum player",
          isError: true);
      }*/
      else if (priceCtrl.text.isEmpty &&
          (datas["price_per_slot"] == null || datas["price_per_slot"] == "")) {
        AppUtills.showSnackBar(
            "Required", "Please enter valid number for slot price",
            isError: true);
      } else if (openingCtrl.text.isEmpty &&
          !is24hrs.value &&
          (datas["opening_time"] == null || datas["opening_time"] == "")) {
        AppUtills.showSnackBar("Required", "Please enter valid opening time",
            isError: true);
      } else if (closingCtrl.text.isEmpty &&
          !is24hrs.value &&
          (datas["closing_time"] == null || datas["closing_time"] == "")) {
        AppUtills.showSnackBar("Required", "Please enter valid closing time",
            isError: true);
      } /* else if (slotLHourCtrl.text.isEmpty) {
      AppUtills.showSnackBar(
          "Required", "Please enter valid number for slot hour",
          isError: true);
      }*/
      else if (slotLMinCtrl.text.isEmpty &&
          (datas["slot_length_min"] == null ||
              datas["slot_length_min"] == "")) {
        AppUtills.showSnackBar(
            "Required", "Please enter valid number for slot minutes",
            isError: true);
      } /*else if (freqCtrl.text.isEmpty) {
      AppUtills.showSnackBar(
          "Required", "Please enter valid number for slot frequency",
          isError: true);
      }*/
      else {
        isLoading(true);
        // if (edit) {
        //   datas["id"] = dataResponse[selectedIndex.value].id ?? "";
        // }
        debugPrint(datas.toString());
        bool saved = await ApiProvider().addFacility(datas, edit);
        isLoading(false);
        update();
      }
    } 
    }
    else {
      print("--------------");
      Map<String, String> data = {
        "title": titleController.text,
        "venue_id": _homeController.getSelectedVenue().id!,
        "id": _homeController.getSelectedVenue().id!,
        "no_of_inventories": /*inventoryCountController.text*/ "100",
        "min_players": /*minPlayerCtrl.text*/ "12",
        "max_players": /*maxPlayerCtrl.text*/ "12",
        "default_players": "12",
        "price_per_slot": priceCtrl.text,
        "opening_time": openingCtrl.text,
        "closing_time": closingCtrl.text,
        "available_24_hours": is24hrs.value ? "1" : "0",
        "slot_length_hrs": "0",
        "slot_length_min": slotLMinCtrl.text,
        "slot_frequency": "1",
        "activity": status.value.toString(),
        "status": status.value ? "1" : "0",
      };
      // debugPrint(titleController.text);
      isLoading(true);
      // print(data);
      if (isEdit.value) {
        data["id"] = dataResponse[selectedIndex.value].id ?? "";
      }
      // debugPrint("${data.toString()}-----------------");
      bool saved = await ApiProvider().addFacility(data, isEdit.value);
      isLoading(false);
      Get.back(result: true);
    }
  }

  reset() {
    titleController.text = "";
    inventoryCountController.text = "";
    minPlayerCtrl.text = "";
    maxPlayerCtrl.text = "";
    priceCtrl.text = "";
    openingCtrl.text = "";
    closingCtrl.text = "";
    slotLHourCtrl.text = "";
    slotLMinCtrl.text = "";
    freqCtrl.text = "";
    status(false);
  }

  Future<Null> selectOpeningTime(BuildContext context) async {
    var _timePicked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (_timePicked != null) {
      final localizations = MaterialLocalizations.of(context);
      final formattedTimeOfDay = localizations.formatTimeOfDay(_timePicked,
          alwaysUse24HourFormat: true);

      openingCtrl.text = formattedTimeOfDay;
    }
  }

  Future<Null> selectClosingTime(BuildContext context) async {
    var _timePicked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (_timePicked != null) {
      final localizations = MaterialLocalizations.of(context);
      final formattedTimeOfDay = localizations.formatTimeOfDay(_timePicked,
          alwaysUse24HourFormat: true);

      closingCtrl.text = formattedTimeOfDay;
    }
  }

  Future<void> fetchFacilities() async {
    isLoading(true);
    dataResponse = <aa.Data>[].obs;
    aa.FacilityListResponse? response = await ApiProvider()
        .fetchFacilities(_homeController.getSelectedVenue().id ?? "");
    if (response != null) {
      if (response.status!) {
        if (response.data != null) {
          dataResponse.value = response.data!;
          update();
        }
      }
    }
    // print(response?.data?.length);
    update();

    isLoading(false);
  }

  void prefillData() {
    if (isEdit.value) {
      aa.Data item = dataResponse[selectedIndex.value];
      titleController.text = item.title ?? "";
      inventoryCountController.text = item.noOfInventories ?? "";
      minPlayerCtrl.text = item.minPlayers ?? "";
      maxPlayerCtrl.text = item.maxPlayers ?? "";
      priceCtrl.text = item.pricePerSlot ?? "";
      openingCtrl.text = item.openingTime ?? "";
      closingCtrl.text = item.closingTime ?? "";
      slotLHourCtrl.text = item.slotLengthHrs ?? "";
      slotLMinCtrl.text = item.slotLengthMin ?? "";
      freqCtrl.text = item.slotFrequency ?? "";
      if ((item.activity ?? "false").contains("true")) {
        status(true);
      }
      update();
    }
  }
}
