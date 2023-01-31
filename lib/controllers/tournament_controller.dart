import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tida_partners/network/responses/TournamentListResponse.dart';
import 'package:tida_partners/network/responses/academy_res.dart' as a;

import '../AppUtils.dart';
import '../network/ApiProvider.dart';

class TournamentController extends GetxController {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final urlController = TextEditingController();
  final addressController = TextEditingController();
  final priceController = TextEditingController();
  final noOfTicketController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  RxString selectedAcademy = "".obs;
  RxString selectedAcademyID = "".obs;
  RxList<Data> data = <Data>[].obs;
  RxString filePath = "".obs;
  final ImagePicker _picker = ImagePicker();
  RxBool isOnline = false.obs;
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
    Map<String, String> data = {
      "academy": selectedAcademyID.value,
      "title": titleController.text,
      "no_of_tickets": noOfTicketController.text,
      "price": priceController.text,
      "start_date": startDateController.text,
      "end_date": endDateController.text,
      "description": descController.text,
      "type": isOnline.value ? "1" : "2",
      "url": isOnline.value ? urlController.text : "-",
      "status": "1",
    };
    print(data);
    for (MapEntry<String, String> item in data.entries) {
      if (item.value.isEmpty) {
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

      saved = await ApiProvider().updateTournament(data, filePath.value.startsWith("http")?"":filePath.value);
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

  void setType(bool value) {
    isOnline(value);
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
      startDateController.text = "${picked.year}-${picked.month}-${picked.day} 00:00:00";
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
      endDateController.text = "${picked.year}-${picked.month}-${picked.day} 00:00:00";
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
      noOfTicketController.text = item.noOfTickets ?? "";
      startDateController.text = item.startDate ?? "";
      endDateController.text = item.endDate ?? "";
      selectedAcademyID.value = item.academyId ?? "-";
      selectedId.value = item.id ?? "";
      selectedAcademy.value = item.academyDetails?.first.name ?? "";
      filePath(item.image);
      update();
      print(selectedAcademyID.value);
    }
  }
}
