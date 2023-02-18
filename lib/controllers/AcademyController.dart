import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tida_partners/network/ApiProvider.dart';
import 'package:tida_partners/network/responses/PackageListResponse.dart'
    as pac;
import 'package:tida_partners/network/responses/VenueListResponse.dart' as v;
import 'package:tida_partners/network/responses/academy_res.dart';

import '../AppUtils.dart';

class AcademyController extends GetxController {
  late RxList<Data> dataList = [Data()].obs;
  late RxList<pac.Data> packageList = <pac.Data>[].obs;
  RxBool loading = false.obs;
  Rx<v.Data?> vData = null.obs;
  RxString selectedVenue = "".obs;
  RxString selectedVenueId = "".obs;
  final academyCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();

  //final locationCtrl = TextEditingController();
  final headCoachCtrl = TextEditingController();
  final timeCtrl = TextEditingController();
  final contactCtrl = TextEditingController();
  final serviceCtrl = TextEditingController();
  final skillCtrl = TextEditingController();
  final coachExpCtrl = "1".obs;
  final ageCtrl = "13-16".obs;

  //final groundSizeCtrl = TextEditingController();
  final floodLightCtrl = "Yes".obs;
  final noOfAssistantCtrl = "1".obs;
  final assistantCoachNameCtrl = TextEditingController();

//  final capacityNameCtrl = TextEditingController();
  //final equipmentCtrl = TextEditingController();

  final packageTitleController = TextEditingController();
  final priceController = TextEditingController();

  RxString filePath = "".obs;
  final ImagePicker _picker = ImagePicker();
  RxBool isEdit = false.obs;
  RxBool isEditPackage = false.obs;
  RxString academyId = "".obs;

  RxInt selectedIndex = (-1).obs;
  RxInt selectedPackage = (-1).obs;

  @override
  void onInit() {
    dataList.clear();
    getAllAcademies();
    super.onInit();
  }

  void getAllAcademies() async {
    loading(true);
    dataList.clear();
    AcademyResponse? response = await ApiProvider().fetchAllAcademies();
    if (response != null) {
      if (response.status == true) {
        dataList = response.data!.obs;
        update();
      }
    }
    loading(false);
  }

  void setSelectedVenue(v.Data? data) {
    if (data == null) {
      return;
    }
    vData = data.obs;
    selectedVenue(data.title);
    selectedVenueId(data.id);
    refresh();
  }

  Future<void> saveAcademy() async {
    if (selectedVenueId.value.isEmpty) {
      AppUtills.showSnackBar("Required", "Please select venue", isError: true);
    } else if (academyCtrl.text.isEmpty) {
      AppUtills.showSnackBar("Required", "Please enter a valid academy name",
          isError: true);
    } else if (descriptionCtrl.text.isEmpty) {
      AppUtills.showSnackBar("Required", "Please enter a valid description",
          isError: true);
    }
    /* else if (locationCtrl.text.isEmpty) {
      AppUtills.showSnackBar(
          "Required", "Please enter a valid venue location (address)",
          isError: true);
    }*/
    else if (headCoachCtrl.text.isEmpty) {
      AppUtills.showSnackBar("Required", "Please enter a valid name",
          isError: true);
    } else if (timeCtrl.text.isEmpty) {
      AppUtills.showSnackBar("Required", "Please enter a valid time",
          isError: true);
    }
    /* else if (serviceCtrl.text.isEmpty) {
      AppUtills.showSnackBar("Required", "Please enter valid data",
          isError: true);
    } */
    else if (skillCtrl.text.isEmpty) {
      AppUtills.showSnackBar("Required", "Please enter valid data",
          isError: true);
    } else if (ageCtrl.value.isEmpty) {
      AppUtills.showSnackBar("Required", "Please enter valid data",
          isError: true);
    }
    /* else if (groundSizeCtrl.text.isEmpty) {
      AppUtills.showSnackBar("Required", "Please enter a valid number",
          isError: true);
    } else if (capacityNameCtrl.text.isEmpty) {
      AppUtills.showSnackBar("Required", "Please enter valid capacity",
          isError: true);
    }*/
    else if (floodLightCtrl.value.isEmpty) {
      AppUtills.showSnackBar(
          "Required", "Please select flood lights availability",
          isError: true);
    }
    /*else if (equipmentCtrl.text.isEmpty) {
      AppUtills.showSnackBar(
          "Required", "Please enter a valid value for equipment",
          isError: true);
    } else if (noOfAssistantCtrl.text.isEmpty) {
      AppUtills.showSnackBar("Required", "Please enter a valid number",
          isError: true);
    } else if (assistantCoachNameCtrl.text.isEmpty) {
      AppUtills.showSnackBar("Required", "Please enter a valid name",
          isError: true);
    }*/
    else {
      loading(true);
      Map<String, String> data = {
        "name": academyCtrl.text,
        "address": "-",
        "description": descriptionCtrl.text,
        "contact_no": "-",
        "head_coach": headCoachCtrl.text,
        "session_timings": timeCtrl.text,
        "skill_level": skillCtrl.text,
        "age_group_of_students": ageCtrl.value,
        "assistant_coach": assistantCoachNameCtrl.text,
        "flood_lights": floodLightCtrl.value,
        "ground_size": "-",
        "status": "1",
        "week_days": "5",
        "remarks_price": "0",
        "remarks_current_capacity": "",
        "remarks_session_plan": "",
        "remarks_students": "",
        "remarks_on_equipment": "",
        "session_plan": "-",
        "capacity": "-",
        "equipment": "-",
        "no_of_assistent_coach": noOfAssistantCtrl.value,
        "coach_experience": coachExpCtrl.value,
        "venue_id": selectedVenueId.value,
        "id": selectedVenueId.value,
        "assistent_coach_name": assistantCoachNameCtrl.text,
      };
      bool saved = false;
      if (!isEdit.value) {
        saved = await ApiProvider().addAcademy(data, filePath.value);
      } else {
        data["id"] = academyId.value;
        saved = await ApiProvider().updateAcademy(data, filePath.value);
      }

      loading(false);
      if (saved) {
        Get.back(result: true);
        //  Get.delete<AcademyController>();
      }
    }
  }

  Future<void> savePackage() async {
    if (packageTitleController.text.isEmpty) {
      AppUtills.showSnackBar("Required", "Please enter package name",
          isError: true);
    } else if (descriptionCtrl.text.isEmpty) {
      AppUtills.showSnackBar("Required", "Please enter a valid description",
          isError: true);
    } else if (priceController.text.isEmpty) {
      AppUtills.showSnackBar("Required", "Please enter a valid price",
          isError: true);
    } else {
      loading(true);
      Map<String, String> data = {
        "title": packageTitleController.text,
        "description": descriptionCtrl.text,
        "academy": academyId.value,
        "price": priceController.text,
      };
      print(data);
      bool saved = false;
      if (!isEditPackage.value) {
        saved = await ApiProvider()
            .addAcademy(data, filePath.value, isPackage: true);
      } else {
        data["id"] = packageList[selectedPackage.value].id.toString();
        saved = await ApiProvider()
            .updateAcademy(data, filePath.value, isPackage: true);
      }

      loading(false);
      if (saved) {
        Get.back(result: true);
        //  Get.delete<AcademyController>();
      }
    }
  }

  Future<void> selectImage() async {
    XFile? f = await _picker.pickImage(source: ImageSource.gallery);
    if (f != null) {
      filePath(f.path);
    }
  }

  void setAcademyData({bool reset = false}) {
    if (reset) {
      packageTitleController.text = "";
      descriptionCtrl.text = "";
      priceController.text = "";
      return;
    }
    if (isEditPackage.value) {
      packageTitleController.text =
          packageList[selectedPackage.value].title ?? "";
      descriptionCtrl.text =
          packageList[selectedPackage.value].description ?? "";
      priceController.text = packageList[selectedPackage.value].price ?? "";
      print("sssssss");
      return;
    }
    if (selectedIndex.value != -1) {
      filePath("");
      Data d = dataList[selectedIndex.value];
      academyCtrl.text = d.name ?? "";
      descriptionCtrl.text = d.description ?? "";
      // locationCtrl.text = d.address ?? "";
      headCoachCtrl.text = d.headCoach ?? "";
      timeCtrl.text = d.sessionTimings ?? "";
      contactCtrl.text = d.contactNo ?? "";
      // serviceCtrl.text = d.se ??"";
      skillCtrl.text = d.skillLevel ?? "";
      coachExpCtrl.value = d.coachExperience ?? "1";
      ageCtrl.value = d.ageGroupOfStudents ?? "13-16";
      //  groundSizeCtrl.text = d.groundSize ?? "";
      floodLightCtrl.value = d.floodLights == "Yes" ? "Yes" : "No";
      noOfAssistantCtrl.value = d.noOfAssistentCoach ?? "1";
      assistantCoachNameCtrl.text = d.assistentCoachName ?? "";
      //   capacityNameCtrl.text = d.capacity ?? "";
      // equipmentCtrl.text = d.equipment ?? "";
      academyId(d.id);
      if (d.venueDetails != null) {
        try{
          selectedVenue(d.venueDetails!.first.title ?? "N/A");
          selectedVenueId(d.venueDetails!.first.id ?? "N/A");
          filePath(d.logo);

        }catch(w){


        }

      } else {
        selectedVenue("");
        selectedVenueId("");
      }
    }
  }

  void resetData() {
    academyCtrl.text = "";
    descriptionCtrl.text = "";
    // locationCtrl.text = "";
    headCoachCtrl.text = "";
    timeCtrl.text = "";
    contactCtrl.text = "";
    skillCtrl.text = "";
    coachExpCtrl.value = "";
    ageCtrl.value = "13-16";
//    groundSizeCtrl.text = "";
    floodLightCtrl.value = "Yes";
    noOfAssistantCtrl.value = "1";
    assistantCoachNameCtrl.text = "";
    // capacityNameCtrl.text = "";
    //  equipmentCtrl.text = "";
    academyId("");
    filePath("");
  }

  void fetchPackages() async {
    loading(true);
    packageList.clear();
    pac.PackageListRes? response =
        await ApiProvider().fetchPackage(academyId.value);
    if (response != null) {
      if (response.status == true) {
        packageList = response.data!.obs;
        update();
      }
    }
    loading(false);
  }

  void deletePackage({bool isAcademy = false}) async {
    loading(true);
    bool response = await ApiProvider().deletePackage(
        isAcademy
            ? academyId.value
            : packageList[selectedPackage.value].id ?? "",
        isAcademy: isAcademy);
    if (response) {
      Get.back();
    }

    if (isAcademy) {
      getAllAcademies();
    }
    loading(false);
  }
}
