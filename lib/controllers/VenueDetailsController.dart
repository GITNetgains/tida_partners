import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tida_partners/network/responses/amenities_res.dart'
    as AmenitiesResponseObj;
import 'package:tida_partners/network/responses/sports_res.dart';

import '../AppColors.dart';
import '../AppUtils.dart';
import '../apputils/image_utils.dart';
import '../network/ApiProvider.dart';
import '../network/responses/SingleVenueDetails.dart' as sVenue;
import '../utilss/theme.dart';
import 'HomeScreenController.dart';

class VenueDetailsController extends GetxController {
  final _homeController = Get.put(HomeScreenController());

  RxList amenetiesList = [].obs;
  RxList<String> amenetiesListInString = [""].obs;
  RxList<String> sportsListInString = <String>[].obs;
  RxList<String> tags = <String>[].obs;
  RxList<String> selectedSport = <String>[].obs;
  Rx<SportsResponse> sportsResponse = SportsResponse().obs;
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

  var videoCtrl = TextEditingController();
  var kGoogleApiKey = "AIzaSyAPNs4LbF8a3SJSG7O6O9Ue_M61inmaBe0";
  RxString lat = "".obs;
  RxString lng = "".obs;

  @override
  void onInit() {
    fetch();
    super.onInit();
  }

  Widget selectLocation() {
    return GooglePlaceAutoCompleteTextField(
        textEditingController: mapCtrl,
        googleAPIKey: kGoogleApiKey,
        inputDecoration: InputDecoration(
          label: setMediumLabel(
            "Enter location",
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: PRIMARY_COLOR),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Colors.greenAccent),
          ),
        ),
        debounceTime: 800,
        isLatLngRequired: true, // if you required coordinates from place detail
        getPlaceDetailWithLatLng: (Prediction prediction) {
          // this method will return latlng with place detail
          print("placeDetails>>> " + prediction.lng.toString());
          print("placeDetails>> " + prediction.lat.toString());
          mapCtrl.text = prediction.description ?? "";
          addressCtrl.text = prediction.description ?? "";
          lat(prediction.lat.toString());
          lng(prediction.lng.toString());
        }, // this callback is called when isLatLngRequired is true
        itemClick: (Prediction prediction) {
          mapCtrl.text = prediction.description ?? "";
        });
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
    } /* else if (taxCtrl.text.isEmpty) {
      AppUtills.showSnackBar("Required", "Please enter a valid tax amount",
          isError: true);
    }*/
    else if (tags.isEmpty) {
      AppUtills.showSnackBar("Required", "Please select Amenities",
          isError: true);
    } else {
      loading(true);
      print(lat.value);
      print(lng.value);
      Map<String, String> data = {
        "title": venueName.value,
        "amenities": getAmenitiesId().join(","),
        "description": vDescription.value,
        "address": addressCtrl.text,
        "address_map": addressCtrl.text,
        "status": "1",
        "video_url": videoCtrl.text,
        "latitude": lat.value,
        "longitude": lng.value,
        "sports": getSelectedSport().join(","),
      };
      bool saved = false;
      if (_homeController.isEdit.value) {
        data["id"] = _homeController.getSelectedVenue().id!;
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
    XFile? f =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 20);
    if (f != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: f.path,
        aspectRatio: CropAspectRatio(ratioX: 16, ratioY: 9),
        cropStyle: CropStyle.rectangle,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 20,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: Colors.red,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.ratio16x9,
              lockAspectRatio: true),
          IOSUiSettings(
            title: 'Crop Image',
            aspectRatioLockEnabled: true,
          ),
        ],
      );
      if (croppedFile != null) {
        final documentsDir = await getApplicationDocumentsDirectory();
   
    String fileName = '${DateTime.now().microsecond}output.jpg';
    
    String filepath = '${documentsDir.path}/$fileName';
        Future<File> futureFile = testCompressAndGetFile(File(croppedFile.path), filepath);

        // Store the resized image in the documents directory.
        await futureFile.then((file) {
          print(file.path);
        });
        filePath(croppedFile.path);
      } else {
        getResizedImage(File(f.path));
        filePath(f.path);
      }
    }
  }

  Future<void> fetch() async {
    loading(true);
    AmenitiesResponseObj.AmenitiesListRes? vlist =
        await ApiProvider().fetchAmenities();
    if (vlist != null) {
      if (vlist.status!) {
        if (vlist.data != null) {
          amenetiesList.assignAll(vlist.data!);
          amenetiesListInString.clear();
          amenetiesList.forEach((element) {
            amenetiesListInString.value.add(element.name);
          });
        }
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

    loading(false);
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
      if (sportsResponse.value.data != null) {
        for (Data value in sportsResponse.value.data!) {
          if (value.id == element) {
            name.add(value.sportName!);
          }
        }
      }
    });
    return name;
  }

  Future<void> fetchVenue() async {
    loading(true);
    filePath(_homeController.getSelectedVenue().image);

    sVenue.SingleVenueDetails? d = await ApiProvider()
        .fetchSingleVenue(_homeController.getSelectedVenue().id!);
    titleController.text = d!.data!.first.title ?? "N/A";
    desController.text = d.data!.first.description ?? "N/A";
    addressCtrl.text = d.data!.first.address ?? "N/A";
    mapCtrl.text = d.data!.first.addressMap ?? "N/A";
    videoCtrl.text = d.data!.first.videoUrl ?? "N/A";
    tags(getAmenitiesNames(d.data!.first.amenities!.split(",")));
    print(d.data!.first.sports);
    lat(d.data!.first.latitude);
    lng(d.data!.first.longitude);
    selectedSport(getSelectedSportName(d.data!.first.sports!.split(",")));

    update();
    loading(false);
  }

  Future<Null> selectOpeningTime(BuildContext context) async {
    var _timePicked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (_timePicked != null) {
      final localizations = MaterialLocalizations.of(context);
      final formattedTimeOfDay = localizations.formatTimeOfDay(_timePicked,
          alwaysUse24HourFormat: true);
//      openingCtrl.text =formattedTimeOfDay;
    }
  }

  Future<Null> selectClosingTime(BuildContext context) async {
    var _timePicked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (_timePicked != null) {
      final localizations = MaterialLocalizations.of(context);
      final formattedTimeOfDay = localizations.formatTimeOfDay(_timePicked,
          alwaysUse24HourFormat: true);
      // closingCtrl.text =formattedTimeOfDay;
    }
  }
}
