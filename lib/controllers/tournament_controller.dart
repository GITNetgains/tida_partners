import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tida_partners/network/responses/SponserResponse.dart' as sp;
import 'package:tida_partners/network/responses/TournamentListResponse.dart';
import 'package:tida_partners/network/responses/academy_res.dart' as a;

import '../AppColors.dart';
import '../AppUtils.dart';
import '../network/ApiProvider.dart';
import '../utilss/theme.dart';

class TournamentController extends GetxController {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final urlController = TextEditingController();
  final priceController = TextEditingController();

  //final noOfTicketController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  RxString selectedAcademy = "".obs;
  RxString selectedAcademyID = "".obs;
  RxList<Data> data = <Data>[].obs;
  RxList<sp.Data> sponserData = <sp.Data>[].obs;
  RxString filePath = "".obs;
  final ImagePicker _picker = ImagePicker();

//  RxBool isOnline = false.obs;
  a.Data? aData;
  RxBool isLoading = false.obs;
  RxBool isEdit = false.obs;
  RxInt selectedIndex = (-1).obs;
  RxString selectedId = "".obs;
  RxList<String> selectedSponsor = <String>[].obs;
  RxList<String> selectedSponsorInList = <String>[].obs;
  RxString lat = "".obs;
  RxString lng = "".obs;
  final addressController = TextEditingController();
  var kGoogleApiKey = "AIzaSyAPNs4LbF8a3SJSG7O6O9Ue_M61inmaBe0";

  Future<void> selectImage() async {
    XFile? f = await _picker.pickImage(source: ImageSource.gallery);
    if (f != null) {
      filePath(f.path);
      print(f.path);
    }
  }

  @override
  void onInit() {
    fetchTournament();
    fetchSponsors();
    super.onInit();
  }

  void saveData() async {
    Map<String, String> data = {
      "academy": selectedAcademyID.value,
      "title": titleController.text,
      "no_of_tickets": "-",
      "price": priceController.text,
      "start_date": startDateController.text,
      "end_date": endDateController.text,
      "description": descController.text,
      "type": "1",
      "latitude": lat.value,
      "longitude": lng.value,
      "address": addressController.text,
      "url": urlController.text,
      "sponsors": getSponsorIds().join(","),
      "status": "1",
    };
    print(data);
    for (MapEntry<String, String> item in data.entries) {
      if (item.value.isEmpty ) {
        AppUtills.showSnackBar("Required", "All fields are required${item.key}",
            isError: true);
        return;
      }
    }
    isLoading(true);
    bool saved = false;

    if (!isEdit.value) {
      saved = await ApiProvider().addTournament(data, filePath.value);
    } else {
      data["id"] = selectedId.value;

      saved = await ApiProvider().updateTournament(
          data, filePath.value.startsWith("http") ? "" : filePath.value);
    }

    print(saved);
    isLoading(false);

    if (saved) {
      AppUtills.showSnackBar("Success", "Tournament Saved");
      Navigator.pop(Get.context!);
      fetchTournament();
    }
  }

  fetchTournament() async {
    isLoading(true);
    TournamentListResponse? response = await ApiProvider().fetchTournaments();
    if (response != null) {
      if (response.status!) {
        data(response.data);
        update();
      }
    }
    isLoading(false);
  }

  fetchSponsors() async {
    isLoading(true);
    sp.SponsorListResponse? response = await ApiProvider().fetchSponsors();
    if (response != null) {
      if (response.status!) {
        if (response.data != null) {
          sponserData.assignAll(response.data!);
          selectedSponsorInList = [""].obs;
          selectedSponsorInList.remove("");
          sponserData.forEach((element) {
            selectedSponsorInList.add(element.name!);
          });
          update();
        }
      }
    }
    isLoading(false);
  }

  void setType(bool value) {
    //isOnline(value);
  }

  void setSelectedAcademy(a.Data? data) {
    if (data == null) {
      return;
    }
    selectedAcademy(data.name);
    selectedAcademyID(data.id);

    aData = data;
  }

  Future<Null> selectStartDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      startDateController.text =
          "${picked.year}-${picked.month}-${picked.day} 00:00:00";
    }
  }

  Future<Null> selectEndTime(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      endDateController.text =
          "${picked.year}-${picked.month}-${picked.day} 00:00:00";
    }
  }

  void preFillData() {
    if (isEdit.value) {
      var item = data[selectedIndex.value];
      titleController.text = item.title ?? "";
      descController.text = item.description ?? "";
      urlController.text = item.url ?? "";
      //addressController.text = item.noOfTickets??"";
      priceController.text = item.price ?? "";
      //   noOfTicketController.text = item.noOfTickets ?? "";
      startDateController.text = item.startDate ?? "";
      endDateController.text = item.endDate ?? "";
      selectedAcademyID.value = item.academyId ?? "-";
      selectedId.value = item.id ?? "";
      try{
        selectedAcademy.value = item.academyDetails?.first.name ?? "";


      }catch(e){}
      filePath(item.image);
      update();
      item.sponsors?.forEach((element) {
        selectedSponsor.add(element.name??"");

      });

      print(selectedAcademyID.value);

    }else{
      titleController.text =  "";
      descController.text =  "";
      urlController.text = "";
      //addressController.text = item.noOfTickets??"";
      priceController.text = "";
      //   noOfTicketController.text = item.noOfTickets ?? "";
      startDateController.text = "";
      endDateController.text = "";
      selectedAcademyID.value =  "";
      selectedId.value = "";
      selectedAcademy.value =  "";
      filePath("");
      selectedSponsor.clear();
      update();


    }
  }
  selectSportItem(String last) {
    if (selectedSponsor.contains(last)) {
      selectedSponsor.remove(last);
    } else {
      selectedSponsor.add(last);
    }

    update();
  }
  List<String> getSponsorIds() {
    List<String> ids = [];
    selectedSponsor.forEach((element) {
      for (sp.Data value in sponserData) {
        if (value.name == element) {
          ids.add(value.id!);
        }
      }
    });
    return ids;
  }

  List<String> getSportsName(List<String> list) {
    List<String> names = [];
    for (var element in list) {
      for (sp.Data value in sponserData) {
        if (value.id == element) {
          names.add(value.name!);
        }
      }
    }
    return names;
  }

  Widget selectLocation() {
    return GooglePlaceAutoCompleteTextField(
        textEditingController: addressController,
        googleAPIKey: kGoogleApiKey,
        inputDecoration: InputDecoration(
          label: setMediumLabel(
            "Enter Google address",
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: PRIMARY_COLOR),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Colors.greenAccent),
          ),
        ),
        debounceTime: 800,
        isLatLngRequired: true,
        // if you required coordinates from place detail
        getPlaceDetailWithLatLng: (Prediction prediction) {
          // this method will return latlng with place detail
          print("placeDetails>>> " + prediction.lng.toString());
          print("placeDetails>> " + prediction.lat.toString());
          addressController.text = prediction.description ?? "";
          addressController.text = prediction.description ?? "";
          lat(prediction.lat.toString());
          lng(prediction.lng.toString());
        },
        // this callback is called when isLatLngRequired is true
        itmClick: (Prediction prediction) {
          addressController.text = prediction.description ?? "";
        });
  }
}
