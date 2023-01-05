import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tida_partners/network/responses/amenities_res.dart'
    as AmenitiesResponseObj;
import 'package:tida_partners/network/responses/sports_res.dart';

import '../AppUtils.dart';
import '../network/ApiProvider.dart';
import '../network/responses/SingleVenueDetails.dart' as sVenue;
import 'HomeScreenController.dart';

class VenueDetailsController extends GetxController {
  final _homeController = Get.put(HomeScreenController());

  RxList amenetiesList = [].obs;
  RxList<String> amenetiesListInString = [""].obs;
  late RxList<String> sportsListInString;
  late RxList<String> tags;
  late RxList<String> selectedSport;
  late Rx<SportsResponse> sportsResponse;
  RxList paymentOptions = [].obs;
  RxString venueName = "".obs;
  RxString vDescription = "".obs;
  RxString vLocation = "".obs;
  RxString mapLink = "".obs;
  RxString vTimeAvailabilty = "".obs;
  RxString vTax = "".obs;
  RxBool loading = false.obs;
  final ImagePicker _picker = ImagePicker();
  RxString filePath = "".obs;

  var titleController = TextEditingController();
  var desController = TextEditingController();
  var addressCtrl = TextEditingController();
  var mapCtrl = TextEditingController();
  var availabilityCtrl = TextEditingController();
  var taxCtrl = TextEditingController();

  @override
  void onInit() {
    tags = ["element"].obs;
    selectedSport = ["element"].obs;
    selectedSport.remove("element");
    tags.remove("element");
    fetch();
    super.onInit();
  }

  Future<void> saveVenue() async {
    if (filePath.value.isEmpty) {
      AppUtills.showSnackBar("Required", "Please select cover image",
          isError: true);
    } else if (titleController.text.isEmpty) {
      AppUtills.showSnackBar("Required", "Please enter a valid venue name",
          isError: true);
    } else if (desController.text.isEmpty) {
      AppUtills.showSnackBar("Required", "Please enter a valid description",
          isError: true);
    } else if (addressCtrl.text.isEmpty) {
      AppUtills.showSnackBar(
          "Required", "Please enter a valid venue location (address)",
          isError: true);
    } else if (mapCtrl.text.isEmpty) {
      AppUtills.showSnackBar("Required", "Please enter location url",
          isError: true);
    } else if (taxCtrl.text.isEmpty) {
      AppUtills.showSnackBar("Required", "Please enter a valid tax amount",
          isError: true);
    } else if (tags.isEmpty) {
      AppUtills.showSnackBar("Required", "Please select Amenities",
          isError: true);
    } else {
      loading(true);
      Map<String, String> data = {
        "title": venueName.value,
        "amenities": getAmenitiesId().join(","),
        "description": vDescription.value,
        "address": vLocation.value,
        "status": "1",
        "sports": getSelectedSport().join(","),
        "address_map": mapLink.value,
      };
      bool saved = false;
      if (_homeController.isEdit.value) {
        data["id"]= _homeController.getSelectedVenue().id!;
        saved = await ApiProvider().updateVenueMultipart(data, filePath.value);
      } else {
        saved = await ApiProvider().addVenueMultipart(data, filePath.value);
      }

      loading(false);
      if (saved) {
        Get.back(result: true);
      }
    }
  }

  Future<void> selectImage() async {
    XFile? f = await _picker.pickImage(source: ImageSource.gallery);
    if (f != null) {
      filePath(f.path);
      print(f.path);
    }
  }

  Future<void> fetch() async {
    loading(true);
    AmenitiesResponseObj.AmenitiesListRes? vlist =
        await ApiProvider().fetchAmenities();
    if (vlist!.status!) {
      if (vlist.data != null) {
        amenetiesList.assignAll(vlist.data!);
        amenetiesListInString.clear();
        amenetiesList.forEach((element) {
          amenetiesListInString.value.add(element.name);
        });
      }

      SportsResponse? sportsList = await ApiProvider().fetchSports();
      if (sportsList != null) {
        sportsResponse = sportsList.obs;
        sportsListInString = [""].obs;
        sportsListInString.remove("");
        sportsResponse.value.data!.forEach((element) {
          sportsListInString.add(element.sportName!);
        });
      }

      loading(false);
    }
    if (_homeController.isEdit.value) {
      fetchVenue();
    }
  }

  selectAmenities(String last) {
    print(last);
    if (tags.contains(last)) {
      tags.remove(last);
    } else {
      tags.add(last);
    }

    update();
  }

  selectSportItem(String last) {
    if (selectedSport.contains(last)) {
      selectedSport.remove(last);
    } else {
      selectedSport.add(last);
    }

    update();
  }

  List<String> getAmenitiesId() {
    List<String> ids = [];
    tags.forEach((element) {
      for (AmenitiesResponseObj.Data value in amenetiesList) {
        if (value.name == element) {
          ids.add(value.id!);
        }
      }
    });
    return ids;
  }

  List<String> getAmenitiesNames(List<String> list) {
    List<String> names = [];
    list.forEach((element) {
      for (AmenitiesResponseObj.Data value in amenetiesList) {
        if (value.id == element) {
          names.add(value.name!);
        }
      }
    });
    return names;
  }

  List<String> getSelectedSport() {
    List<String> ids = [];
    selectedSport.forEach((element) {
      for (Data value in sportsResponse.value.data!) {
        if (value.sportName == element) {
          ids.add(value.id!);
        }
      }
    });
    return ids;
  }

  List<String> getSelectedSportName(List<String> list) {
    List<String> name = [];
    list.forEach((element) {
      for (Data value in sportsResponse.value.data!) {
        if (value.id == element) {
          name.add(value.sportName!);
        }
      }
    });
    return name;
  }

  Future<void> fetchVenue() async {
    loading(true);
    sVenue.SingleVenueDetails? d = await ApiProvider()
        .fetchSingleVenue(_homeController.getSelectedVenue().id!);
    titleController.text = d!.data!.first.title ?? "N/A";
    desController.text = d.data!.first.description ?? "N/A";
    addressCtrl.text = d.data!.first.address ?? "N/A";
    mapCtrl.text = d.data!.first.addressMap ?? "N/A";
    availabilityCtrl.text = d.data!.first.addressMap ?? "N/A";
    taxCtrl.text = d.data!.first.id ?? "N/A";
    tags(getAmenitiesNames(d.data!.first.amenities!.split(",")));
    print(d.data!.first.sports);
    selectedSport(getSelectedSportName(d.data!.first.sports!.split(",")));
    filePath('https://tidasports.com/secure/uploads/tbl_venue/${d.data!.first.image}');
    print(d.data?.first.image);
    update();
    loading(false);
  }
}
