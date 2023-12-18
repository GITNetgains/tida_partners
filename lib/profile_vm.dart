// ignore_for_file: depend_on_referenced_packages, avoid_init_to_null

import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tida_partners/login_screen.dart';
import 'package:tida_partners/my_profile_response.dart';
import 'package:tida_partners/network/ApiProvider.dart';
import 'package:tida_partners/network/api_constants.dart';
import 'package:tida_partners/utilss/SharedPref.dart';


class ProfileVM extends GetxController {
  // final homeVm = Get.put(HomeVM());
    RxBool isLoading = false.obs;
  String? userName, userImage, userEmail, userPhone, userId, token;
  XFile? selectedAvatar;
  bool? isEditing = false;
  File? croppedFile;
  String? userPropic;
  bool? isEnabled = false;

  bool? isUploading = false;

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emCtrl = TextEditingController();
  TextEditingController phCtrl = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    init();
  }

  bool btnLoader = false;

  void showLoader() {
    debugPrint("ShowLoader");
    btnLoader = true;
    update();
  }

  Future deleteProfile() async {
    isLoading(true);
    bool result = await ApiProvider().deleteProfile();
    isLoading(false);
    if (result) {
      Get.offAll(LoginScreen());
    }
  }

  void hideLoader() {
    debugPrint("hideLoader");
    btnLoader = false;
    update();
  }

  bool btnLoader1 = false;

  void showLoader1() {
    debugPrint("ShowLoader");
    btnLoader1 = true;
    update();
  }

  void hideLoader1() {
    debugPrint("hideLoader");
    btnLoader1 = false;
    update();
  }

  Future<void> init() async {
    userName = await Preferences.getName();
    userEmail = await Preferences.getEmail();
    userPhone = await Preferences.getPhone();
    userId = await Preferences.getUserId();
    // userImage = await Preferences.;
    token = await Preferences.getToken();
    nameCtrl.text = isProperString(userName)! ? userName! : "";
    emCtrl.text = isProperString(userEmail)! ? userEmail! : "";
    phCtrl.text = isProperString(userPhone)! ? userPhone! : "";
    update();
  }

  bool? isProperString(String? s) {
    if (s != null && s.trim().isNotEmpty && s.trim() != "null") {
      return true;
    } else {
      return false;
    }
  }

  void pickImage(ImageSource source) async {
    selectedAvatar = await ImagePicker().pickImage(source: source);
    if (selectedAvatar != null) {
      CroppedFile? cf = await ImageCropper().cropImage(
        sourcePath: selectedAvatar!.path,
        cropStyle: CropStyle.circle,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 20,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: Colors.red,
              toolbarWidgetColor: Colors.white,),
          IOSUiSettings(
            title: 'Crop Image',
          ),
        ],
      );
      if (cf != null) {
        croppedFile = File(cf.path);
      }
    }

    update();
  }

  addPropicApi2() async {
    var headers = {
      'Content-Type': 'multipart/form-data;',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest('POST',
        Uri.parse('${BASE_URL}/Userapi/updateProfile'));
    request.fields.addAll({
      'userid': userId!,
      'token': token!,
      'name': nameCtrl.text.trim(),
      'phone': phCtrl.text.trim(),
    });
    if (croppedFile != null) {
      request.files
          .add(await http.MultipartFile.fromPath('image', croppedFile!.path));
    }
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String? res = await response.stream.bytesToString();
      ProfileResponse? resp = null;
      if (response.statusCode == 200) {
        debugPrint("IMAGE SUCCESS $res");
        //ApiService().returnResponse(response.data);
        resp = profileResponseFromJson(res);
        //userPropic = res!.data!.s3FileName!.toString();

        await Preferences.setUserId(
            resp!.data!.id.toString());
        await Preferences.setName(
            resp.data!.name.toString());
        await Preferences.setToken(
            resp.data!.token.toString());
        await Preferences.setEmail(
             resp.data!.email.toString());
        await Preferences.setPhone(
           resp.data!.phone.toString());
        await Preferences.setProfileimage(
             resp.data!.image.toString());
        isEditing = false;
        isEnabled = true;
        init();
        // await notificationApi();
        isUploading = false;
        //isNotUploading = true;
        // HomeScreenController.updateImageVariable();
      } else {
        isUploading = false;
        Get.snackbar("Image Upload Failed Response Code ${response.statusCode}",
            "Error");
      }
      update();
    } else {
      print(response.reasonPhrase);
      isUploading = false;
      Get.snackbar("Image Upload Failed Response Code ${response.reasonPhrase}",
          "Error");
      update();
    }
  }

  addPropicApi() async {
    isUploading = true;
    update();
    debugPrint("MAKING IMAGE REQUEST");
    // String? userId = await SecuredStorage.readStringValue(Keys.userId);
    //var auth = await SharedPref.getString(SharedPref.authToken);
    try {
      ///[1] CREATING INSTANCE
      var dioRequest = dio.Dio();
      dioRequest.options.baseUrl =
          BASE_URL + "Userapi/editrpofile";

      //[2] ADDING TOKEN
      dioRequest.options.headers = {
        //"Authorization": "Bearer " + auth!,
        //'Content-Type': 'application/x-www-form-urlencoded'
        // 'Content-Type': 'multipart/form-data',
        //'enctype': 'multipart/form-data'
        'Cookie':
            '__88ok4w0s48kwosg08404k0sswsowwg08ccc0c0s0=651fb6f5a64f8009c94b84cf4bc56535b42a677f; language=english'
      };

      //[3] ADDING EXTRA INFO
      var formData = dio.FormData.fromMap({
        'userid': userId,
        'token': token,
        'name': nameCtrl.text.trim(),
        'phone': phCtrl.text.trim(),
      });

      //[4] ADD IMAGE TO UPLOAD
      if (croppedFile != null) {
        var file = await dio.MultipartFile.fromFile(croppedFile!.path,
            filename: "profile_pic_${DateTime.now().toIso8601String()}",
            contentType: MediaType(
              "image",
              "profile_pic_${DateTime.now().toIso8601String()}",
            ));

        formData.files.add(MapEntry('image', file));
      }

      //[5] SEND TO SERVER
      if (croppedFile != null) {
        var response = await dioRequest.post(
          BASE_URL + "Userapi/editrpofile",
          data: formData,
        );
        ProfileResponse? resp = null;
        if (response.statusCode == 200) {
          debugPrint("IMAGE SUCCESS ${response.data}");
          //ApiService().returnResponse(response.data);
          resp = ProfileResponse.fromJson(response.data);
          //userPropic = res!.data!.s3FileName!.toString();

          await Preferences.setUserId(
               resp.data!.id.toString());
          await Preferences.setName(
              resp.data!.name.toString());
          await Preferences.setToken(
               resp.data!.token.toString());
          await Preferences.setEmail(
             resp.data!.email.toString());
          await Preferences.setPhone(
             resp.data!.phone.toString());
          await Preferences.setProfileimage(
               resp.data!.image.toString());
          isEditing = false;
          isEnabled = true;

          // await notificationApi();
          isUploading = false;
          //isNotUploading = true;
        } else {
          isUploading = false;
          Get.snackbar(
              "Image Upload Failed Response Code ${response.statusCode}",
              "Error");
        }
        update();
        //Navigator.of(context).pop();
      } else {
        //Navigator.of(context).pop();
        // isNotUploading = true;
        isUploading = false;
        update();
      }
    } on dio.DioError catch (err) {
      debugPrint("EROR111 ${err.message}");
      isUploading = false;
      Get.snackbar(err.message ?? "", "Error");
      if (err.response == null) {
        debugPrint("Error 1");
        //isNotUploading = true;
      }
      if (err.response != null && err.response!.statusCode == 413) {
        debugPrint("Error 413");
        //isNotUploading = true;
        //update();
      }
      if (err.response != null && err.response!.statusCode == 400) {
        debugPrint("Error 400");
        //isNotUploading = true;
        //update();
      }
      update();
    }
  }
}
