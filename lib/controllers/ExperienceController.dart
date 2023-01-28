import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tida_partners/network/responses/ExperienceList.dart';
import 'package:tida_partners/network/responses/VenueListResponse.dart' as a;

import '../AppUtils.dart';
import '../network/ApiProvider.dart';

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
    print("called");
    Map<String, String> data = {
      "venue_id": selectedAcademyID.value,
      "title": titleController.text,
      "price": priceController.text,
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
    print("1111");
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
      AppUtills.showSnackBar("Success", "Tournament Saved");
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
      filePath(item.image);
      update();
    }
  }
}
