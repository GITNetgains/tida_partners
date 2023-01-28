import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tida_partners/network/ApiProvider.dart';
import 'package:tida_partners/network/responses/VenueListResponse.dart' as v;
import 'package:tida_partners/network/responses/academy_res.dart';

import '../AppUtils.dart';

class AcademyController extends GetxController {
  late RxList<Data> dataList=[Data()].obs;
  RxBool loading = false.obs;
  Rx<v.Data?> vData = null.obs;
  RxString selectedVenue = "".obs;
  RxString selectedVenueId = "".obs;
  final academyCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();
  final locationCtrl = TextEditingController();
  final headCoachCtrl = TextEditingController();
  final timeCtrl = TextEditingController();
  final contactCtrl = TextEditingController();
  final serviceCtrl = TextEditingController();
  final skillCtrl = TextEditingController();
  final coachExpCtrl = TextEditingController();
  final ageCtrl = TextEditingController();
  final groundSizeCtrl = TextEditingController();
  final floodLightCtrl = TextEditingController();
  final noOfAssistantCtrl = TextEditingController();
  final assistantCoachNameCtrl = TextEditingController();
  final capacityNameCtrl = TextEditingController();
  final equipmentCtrl = TextEditingController();



  final packageTitleController = TextEditingController();
  final priceController = TextEditingController();

  RxString filePath = "".obs;
  final ImagePicker _picker = ImagePicker();
  RxBool isEdit = false.obs;
  RxBool isEditPackage = false.obs;
  RxString academyId = "".obs;

  RxInt selectedIndex = (-1).obs;

  @override
  void onInit() {
    dataList.clear();
    getAllAcademies();
    super.onInit();
  }

  void getAllAcademies() async {
    loading(true);
    AcademyResponse? response = await ApiProvider().fetchAllAcademies();
    if (response != null) {
      if (response.status == true) {
        dataList = response.data!.obs;
        update();
      }
    }
    loading(false);


  }

  void setSelectedVenue(v.Data data) {
    vData = data.obs;
    selectedVenue(data.title);
    refresh();
  }

  Future<void> saveAcademy() async {
    if (selectedVenue.isEmpty) {
      AppUtills.showSnackBar("Required", "Please select venue", isError: true);
    } else if (academyCtrl.text.isEmpty) {
      AppUtills.showSnackBar("Required", "Please enter a valid academy name",
          isError: true);
    } else if (descriptionCtrl.text.isEmpty) {
      AppUtills.showSnackBar("Required", "Please enter a valid description",
          isError: true);
    } else if (locationCtrl.text.isEmpty) {
      AppUtills.showSnackBar(
          "Required", "Please enter a valid venue location (address)",
          isError: true);
    } else if (headCoachCtrl.text.isEmpty) {
      AppUtills.showSnackBar("Required", "Please enter a valid name",
          isError: true);
    } else if (timeCtrl.text.isEmpty) {
      AppUtills.showSnackBar("Required", "Please enter a valid time",
          isError: true);
    } else if (contactCtrl.text.isEmpty) {
      AppUtills.showSnackBar("Required", "Please enter a valid contact number",
          isError: true);
    }/* else if (serviceCtrl.text.isEmpty) {
      AppUtills.showSnackBar("Required", "Please enter valid data",
          isError: true);
    } */else if (skillCtrl.text.isEmpty) {
      AppUtills.showSnackBar("Required", "Please enter valid data",
          isError: true);
    } else if (ageCtrl.text.isEmpty) {
      AppUtills.showSnackBar("Required", "Please enter valid data",
          isError: true);
    } else if (groundSizeCtrl.text.isEmpty) {
      AppUtills.showSnackBar("Required", "Please enter a valid number",
          isError: true);
    } else if (capacityNameCtrl.text.isEmpty) {
      AppUtills.showSnackBar("Required", "Please enter valid capacity",
          isError: true);
    } else if (floodLightCtrl.text.isEmpty) {
      AppUtills.showSnackBar("Required", "Please enter a valid number",
          isError: true);
    } /*else if (equipmentCtrl.text.isEmpty) {
      AppUtills.showSnackBar(
          "Required", "Please enter a valid value for equipment",
          isError: true);
    } else if (noOfAssistantCtrl.text.isEmpty) {
      AppUtills.showSnackBar("Required", "Please enter a valid number",
          isError: true);
    } else if (assistantCoachNameCtrl.text.isEmpty) {
      AppUtills.showSnackBar("Required", "Please enter a valid name",
          isError: true);
    }*/ else {
      loading(true);
      Map<String, String> data = {
        "name": academyCtrl.text,
        "address": locationCtrl.text,
        "description": descriptionCtrl.text,
        "contact_no": contactCtrl.text,
        "head_coach": headCoachCtrl.text,
        "session_timings": timeCtrl.text,
        "skill_level": skillCtrl.text,
        "age_group_of_students": ageCtrl.text,
        "assistant_coach": assistantCoachNameCtrl.text,
        "flood_lights": floodLightCtrl.text,
        "ground_size": groundSizeCtrl.text,
        "status": "1",
        "week_days": "5",
        "remarks_price": "0",
        "remarks_current_capacity": "",
        "remarks_session_plan": "",
        "remarks_students": "",
        "remarks_on_equipment": "",
        "session_plan": "-",
        "capacity": capacityNameCtrl.text,
        "equipment": equipmentCtrl.text,
        "no_of_assistent_coach": noOfAssistantCtrl.text,
        "coach_experience": coachExpCtrl.text,
        "venue_id": selectedVenueId.value?? "0",
        "id": academyId.value,
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

  Future<void> selectImage() async {
    XFile? f = await _picker.pickImage(source: ImageSource.gallery);
    if (f != null) {
      filePath(f.path);

    }
  }

  void setAcademyData() {
    if (isEditPackage.value) {



      return;
    }
    if (selectedIndex.value != -1) {
      Data d = dataList[selectedIndex.value];
      academyCtrl.text = d.name ?? "";
      descriptionCtrl.text = d.description ?? "";
      locationCtrl.text = d.address ?? "";
      headCoachCtrl.text = d.headCoach ?? "";
      timeCtrl.text = d.sessionTimings ?? "";
      contactCtrl.text = d.contactNo ?? "";
      // serviceCtrl.text = d.se ??"";
      skillCtrl.text = d.skillLevel ?? "";
      coachExpCtrl.text = d.coachExperience ?? "";
      ageCtrl.text = d.ageGroupOfStudents ?? "";
      groundSizeCtrl.text = d.groundSize ?? "";
      floodLightCtrl.text = d.floodLights ?? "";
      noOfAssistantCtrl.text = d.noOfAssistentCoach ?? "";
      assistantCoachNameCtrl.text = d.assistentCoachName ?? "";
      capacityNameCtrl.text = d.capacity ?? "";
      equipmentCtrl.text = d.equipment ?? "";
      academyId(d.id);
      if(d.venueDetails!=null){
      selectedVenue(d.venueDetails!.first.title??"N/A");
      selectedVenueId(d.venueDetails!.first.id??"N/A");
      filePath(d.logo);

      }else{
        selectedVenue("");
        selectedVenueId("");

      }

    }
  }

  void resetData(){
    academyCtrl.text =  "";
    descriptionCtrl.text =  "";
    locationCtrl.text =  "";
    headCoachCtrl.text =  "";
    timeCtrl.text =  "";
    contactCtrl.text = "";
    skillCtrl.text = "";
    coachExpCtrl.text = "";
    ageCtrl.text =  "";
    groundSizeCtrl.text = "";
    floodLightCtrl.text =  "";
    noOfAssistantCtrl.text =  "";
    assistantCoachNameCtrl.text =  "";
    capacityNameCtrl.text =  "";
    equipmentCtrl.text =  "";
    academyId("");
    filePath("");

  }
}
