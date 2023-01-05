import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tida_partners/add_venue.dart';
import 'package:tida_partners/network/responses/amenities_res.dart'
    as AmenitiesResponseObj;

import '../AppUtils.dart';
import '../network/ApiProvider.dart';
import '../network/responses/VenueListResponse.dart';
import '../network/responses/VenueListResponse.dart' as VL;
import '../network/responses/media_response.dart' as MediaData;
import '../network/responses/sports_res.dart';
import '../network/responses/sports_res.dart' as sd;
import '../view_venu.dart';

class HomeScreenController extends GetxController {
  RxList venueList = [].obs;
  RxBool loading = false.obs;
  RxInt index = 0.obs;
  RxBool isEdit = false.obs;
  RxString imagePath = "".obs;
  final ImagePicker _picker = ImagePicker();
  RxList<MediaData.Data?> imageList = [MediaData.Data()].obs;
  RxList amenetiesList = [].obs;
  RxList<String> amenetiesListInString = [""].obs;
  late RxList<String> sportsListInString;
  late Rx<SportsResponse> sportsResponse;

  @override
  void onInit() {
    imageList.clear();
    fetch();
    super.onInit();
  }

  Future<void> fetch() async {
    loading(true);
    VenueList? vlist = await ApiProvider().fetchVenues();
    if (vlist!.status!) {
      if (vlist.data != null) {
        venueList.assignAll(vlist.data!);
      }
    }
    loading(false);
  }

  selectImage() async {
    XFile? f = await _picker.pickImage(source: ImageSource.gallery);
    if (f != null) {
      imagePath(f.path);
      uploadImage();
    }
  }

  void viewVenue(int i) {
    index(i);
    imageList.clear();
    fetchMedia();
    fetchSpostsAndAmenities();
    Get.to(() => ViewVenu());
  }

  VL.Data getSelectedVenue() {
    return venueList[index.value];
  }

  void editVenue(int i) async {
    index(i);
    isEdit(true);
    bool data = await Get.to(() => AddVenue());
    if (data) {
      fetch();
    }
  }

  Future<void> uploadImage() async {
    loading(true);
    Map<String, String> data = {
      "name": imagePath.value.split("/").last,
      "image": imagePath.value.split("/").last,
      "post_id": getSelectedVenue().id!,
      "post_type": "venue",
      "status": "1",
    };

    final api = await ApiProvider().addMedia(data, imagePath.value);
    loading(false);
    if (api) {
      AppUtills.showSnackBar("Success", "Image Uploaded");
      fetchMedia();
    }

  }

  Future<void> deleteMedia(int index) async {
    final api = await ApiProvider().deleteMedia(imageList[index]!.id!);
    if (api) {
      imageList.removeAt(index);
      update();
      AppUtills.showSnackBar("Success", "Image deleted");
      fetchMedia();
    }
  }

  Future<void> fetchMedia() async {
    loading(true);
    MediaData.MediaListResponse? datares =
        await ApiProvider().fetchMedia(getSelectedVenue().id!);
    if (datares?.status == true) {
      imageList(datares!.data!);
      update();
    }
    loading(false);
  }

  Future<void> fetchSpostsAndAmenities() async {
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

  List<String> getSelectedSportName(List<String> list) {
    List<String> name = [];
    list.forEach((element) {
      for (sd.Data value in sportsResponse.value.data!) {
        if (value.id == element) {
          name.add(value.sportName!);
        }
      }
    });
    return name;
  }
}
