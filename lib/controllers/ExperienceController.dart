import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tida_partners/network/responses/ExperienceList.dart';
import 'package:tida_partners/network/responses/VenueListResponse.dart' as a;

import '../AppColors.dart';
import '../AppUtils.dart';
import '../network/ApiProvider.dart';
import '../utilss/theme.dart';

class ExperienceController extends GetxController {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final priceController = TextEditingController();
  RxString selectedAcademy = "".obs;
  RxString selectedAcademyID = "".obs;
  RxList<Data> data = <Data>[].obs;
  RxString filePath = "".obs;
  final ImagePicker _picker = ImagePicker();
  a.Data? aData;
  RxBool isLoading = false.obs;
  RxBool isEdit = false.obs;
  RxInt selectedIndex = (-1).obs;
  RxString selectedId = "".obs;
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
    super.onInit();
  }

  void saveData() async {
    Map<String, String> data = {
      "venue_id": selectedAcademyID.value,
      "id": selectedAcademyID.value,
      "title": titleController.text,
      "price": priceController.text,
      "latitude": lat.value,
      "longitude": lng.value,
      "address": addressController.text,
      "description": descController.text,
      "status": "1",
    };
    for (MapEntry<String, String> item in data.entries) {
      print("called");
      if (item.value.isEmpty) {
        AppUtills.showSnackBar("Required", "All fields are required${item.key}",
            isError: true);
        return;
      }
    }
    isLoading(true);

    bool saved = false;
    try {
      if (!isEdit.value) {
        saved = await ApiProvider().addExperience(data, filePath.value);
      } else {
        data["id"] = selectedId.value;
        if (filePath.value.startsWith("http")) {
          filePath("");
        }
        saved = await ApiProvider().updateExperiences(data, filePath.value);
      }
    } catch (e) {
      print("called${e}");
      isLoading(false);
    }
    isLoading(false);

    if (saved) {
      AppUtills.showSnackBar("Success", "Experience Saved");
      Navigator.pop(Get.context!);
      fetchTournament();
    }
  }

  fetchTournament() async {
    isLoading(true);
    ExperienceListResponse? response = await ApiProvider().fetchExperiences();
    if (response != null) {
      if (response.status!) {
        data(response.data);
        print(data.first.title);
        update();
      }
    }
    isLoading(false);
  }

  void setSelectedAcademy(a.Data data) {
    selectedAcademy(data.title);
    selectedAcademyID(data.id);
    aData = data;
    update();
  }


  void preFillData() {
    if (isEdit.value) {
      var item = data[selectedIndex.value];
      titleController.text = item.title ?? "";
      descController.text = item.description ?? "";
      priceController.text = item.price ?? "";
      selectedAcademyID.value = item.venueId ?? "";
      selectedId.value = item.id ?? "";
      selectedAcademy.value = item.venuName ?? "";
      selectedAcademyID.value = item.venueId ?? "";
      addressController.text = item.address ?? "";
      print( item.address );
      lat(item.latitude??"");
      lng(item.longitude??"");
      filePath(item.image);
      update();
    }
  }

  Widget selectLocation() {
    return GooglePlaceAutoCompleteTextField(
        textEditingController: addressController,
        googleAPIKey: kGoogleApiKey,
        inputDecoration: InputDecoration(
          label: setMediumLabel(
            "Enter Google address",
          ),
          focusedBorder: OutlineInputBorder(
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
