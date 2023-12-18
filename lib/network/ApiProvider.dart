import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:tida_partners/AppUtils.dart';
import 'package:tida_partners/network/responses/AllOrdersResponse.dart';
import 'package:tida_partners/network/responses/CMSresponse.dart';
import 'package:tida_partners/network/responses/LoginResponse.dart';
import 'package:tida_partners/network/responses/PackageListResponse.dart';
import 'package:tida_partners/network/responses/TournamentListResponse.dart';
import 'package:tida_partners/network/responses/amenities_res.dart';
import 'package:tida_partners/network/responses/media_response.dart';
import 'package:tida_partners/utilss/SharedPref.dart';
import 'package:tida_partners/utilss/common_utils.dart';

import '../booking_slot/fetch_facility_slots_model.dart';
import 'api_constants.dart';
import 'responses/ExperienceList.dart';
import 'responses/SingleVenueDetails.dart';
import 'responses/SponserResponse.dart';
import 'responses/VenueListResponse.dart';
import 'responses/academy_res.dart';
import 'responses/facilityListResponse.dart';
import 'responses/sports_res.dart';

class ApiProvider {
  //Public api request
  Future<http.Response> makeHttpsCall(String url,
      {bool showError = true}) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Cache-Control': 'no-cache'
      //'Authorization': "Bearer ${Preferences.getToken().trim()}"
    };

    return await http.get(Uri.parse(url), headers: headers);
  }

  Future<bool> loginUser(Map<String, String> data) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
    };
    http.Response res =
        await http.post(Uri.parse(LOGIN_URL), headers: headers, body: data);
    print(jsonEncode(res.body));

    if (res.statusCode == 200) {
      LoginResponse datares = LoginResponse.fromJson(jsonDecode(res.body));
      if (datares.status == true) {
        Preferences.setLoggedIn(true);
        Preferences.setToken(datares.data?.token ?? "");
        Preferences.setUserId(datares.data?.id ?? "");
        Preferences.setUserId(datares.data?.id ?? "");
        Preferences.setName(datares.data?.name ?? "");
        Preferences.setEmail(datares.data?.email ?? "");
        Preferences.setPhone(datares.data?.phone ?? "N/A");
        Preferences.setStatus(datares.data?.status ?? "1");
        print(res.body);
        print(res.body);
        Preferences.setUserData(res.body);
        return true;
      } else {
        AppUtills.showSnackBar(
            "Error", datares.message ?? "Invalid email or password",
            isError: true);
      }
    }
    return false;
  }

  Future<bool> signUp(Map<String, String> data) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
    };
    http.Response res =
        await http.post(Uri.parse(REGISTER_URL), headers: headers, body: data);
    if (res.statusCode == 200) {
      LoginResponse datares = LoginResponse.fromJson(jsonDecode(res.body));
      if (datares.status == true) {
        Preferences.setLoggedIn(true);
        Preferences.setToken(datares.data?.token ?? "");
        Preferences.setUserId(datares.data?.id ?? "");
        Preferences.setUserId(datares.data?.id ?? "");
        Preferences.setName(datares.data?.name ?? "");
        Preferences.setEmail(datares.data?.email ?? "");
        Preferences.setPhone(datares.data?.phone ?? "N/A");
        Preferences.setStatus(datares.data?.status ?? "1");
        AppUtills.showSnackBar(
            "Success", "User registered. Please login to continue.",
            isError: false);
        return true;
      } else {
        AppUtills.showSnackBar(
            "Error", datares.message ?? "Invalid email or password",
            isError: true);
      }
    }
    return false;
  }

  Future<bool> forgotPass(Map<String, String> data) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
    };
    http.Response res = await http.post(Uri.parse(FORGOT_PASSWORD),
        headers: headers, body: data);
    print(jsonEncode(res.body));
    if (res.statusCode == 200) {
      LoginResponse datares = LoginResponse.fromJson(jsonDecode(res.body));
      if (datares.status == true) {
        AppUtills.showSnackBar("Success",
            "Please check your email for password reset instructions. ",
            isError: false);
        return true;
      } else {
        AppUtills.showSnackBar("Error",
            datares.message ?? "Something Went Wrong. Please try again.",
            isError: true);
      }
    }
    return false;
  }

  static dynamic returnResponse(http.Response response) {
    try {
      dynamic responseJson = /*jsonDecode(*/ response.body /*)*/;
      debugPrint("RESPONSE $responseJson");
      return responseJson;
    } catch (e) {
      return {};
    }
  }

  static Future changepass(Map data) async {
    var client = http.Client();
    dynamic responseJson;
    final response = await client.post(Uri.parse(CHANGE_PASSWORD),
        // headers: <String, String>{
        // 'Content-Type': 'application/x-www-form-urlencoded',
        // },
        body: /*jsonEncode(*/ data /*)*/);
    responseJson = returnResponse(response);
    return responseJson;
  }

  static Future updateprofile(Map data) async {
    var client = http.Client();
    dynamic responseJson;
    final response = await client.post(Uri.parse(UPDATE_PROFILE),
        // headers: <String, String>{
        // 'Content-Type': 'application/x-www-form-urlencoded',
        // },
        body: /*jsonEncode(*/ data /*)*/);
    responseJson = returnResponse(response);
    return responseJson;
  }

  Future<bool> addVenueMultipart(Map<String, String> data, String path) async {
    String token = Preferences.getToken();
    String user_id = Preferences.getUserId();
    data['userid'] = user_id;
    data['token'] = token;
    //data['image'] = "null";
    //for multipartrequest
    var request = http.MultipartRequest('POST', Uri.parse(ADD_VENUE));
    //for token
    request.headers.addAll({
      'Accept': 'application/json',
    });

    //for image and videos and files
    request.fields.assignAll(data);

    if (path.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath("image", path));
    } else {
      data['image'] = "null";
    }

    //for completeing the request
    var response = await request.send();

    //for getting and decoding the response into json format
    var responsed = await http.Response.fromStream(response);
    final responseData = json.decode(responsed.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> addTournament(Map<String, String> data, String path) async {
    String token = Preferences.getToken();
    String user_id = Preferences.getUserId();
    data['userid'] = user_id;
    data['token'] = token;
    var request = http.MultipartRequest('POST', Uri.parse(ADD_TOURNAMENT));
    //for token
    request.headers.addAll({
      'Accept': 'application/json',
    });

    //for image and videos and files
    request.fields.assignAll(data);
    print(path);
    print(path);
    print(path);
    if (path.trim().isNotEmpty) {
      print("---000000---");
      request.files.add(await http.MultipartFile.fromPath("image", path));
    } else {
      data['image'] = "null";
    }
    //for completeing the request
    var response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateTournament(Map<String, String> data, String path) async {
    String token = Preferences.getToken();
    String user_id = Preferences.getUserId();
    data['userid'] = user_id;
    data['token'] = token;
    debugPrint(data.toString());
    var request = http.MultipartRequest('POST', Uri.parse(UPDATE_TOURNAMENT));
    //for token
    request.headers.addAll({
      'Accept': 'application/json',
    });

    //for image and videos and files
    request.fields.assignAll(data);

    if (path.trim().isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath("image", path));
    } else {
      data['image'] = "null";
    }
    //for completeing the request
    var response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> addExperience(Map<String, String> data, String path) async {
    String token = Preferences.getToken();
    String user_id = Preferences.getUserId();
    data['userid'] = user_id;
    data['user_id'] = user_id;
    data['token'] = token;
    print(data.toString());
    var request = http.MultipartRequest('POST', Uri.parse(ADD_EXPERIENCE));
    //for token
    request.headers.addAll({
      'Accept': 'application/json',
    });

    //for image and videos and files
    request.fields.assignAll(data);

    if (path.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath("image", path));
    } else {
      data['image'] = "null";
    }
    //for completeing the request
    var response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateExperiences(Map<String, String> data, String path) async {
    String token = Preferences.getToken();
    String user_id = Preferences.getUserId();
    data['userid'] = user_id;
    data['token'] = token;
    var request = http.MultipartRequest('POST', Uri.parse(UPDATE_EXPERIENCE));
    //for token
    request.headers.addAll({
      'Accept': 'application/json',
    });

    //for image and videos and files
    request.fields.assignAll(data);

    if (path.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath("image", path));
    } else {
      data['image'] = "null";
    }
    //for completeing the request
    var response = await request.send();
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> addAcademy(Map<String, String> data, String path,
      {bool isPackage = false}) async {
    String token = Preferences.getToken();
    String user_id = Preferences.getUserId();
    data['userid'] = user_id;
    data['token'] = token;
    var request = http.MultipartRequest(
        'POST', Uri.parse(isPackage ? ADD_PACKAGE : ADD_ACADEMY));
    request.headers.addAll({
      'Accept': 'application/json',
    });
    debugPrint(isPackage ? ADD_PACKAGE : ADD_ACADEMY);
    //for image and videos and files
    request.fields.assignAll(data);

    if (path.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath("logo", path));
    } else {
      data['logo'] = "null";
    }

    //for completeing the request
    var response = await request.send();

    //for getting and decoding the response into json format
    var responsed = await http.Response.fromStream(response);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateAcademy(Map<String, String> data, String path,
      {bool isPackage = false}) async {
    String token = Preferences.getToken();
    String user_id = Preferences.getUserId();
    data['userid'] = user_id;
    data['token'] = token;

    var request = http.MultipartRequest(
        'POST', Uri.parse(isPackage ? UPDATE_PACKAGE : UPDATE_ACADEMY));
    request.headers.addAll({
      'Accept': 'application/json',
    });

    //for image and videos and files
    request.fields.assignAll(data);

    try {
      if (path.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath("logo", path));
      } else {
        // data['logo'] = "null";
      }
    } catch (e) {}

    //for completeing the request
    var response = await request.send();

    //for getting and decoding the response into json format
    var responsed = await http.Response.fromStream(response);
    final responseData = json.decode(responsed.body);
    print(jsonEncode(responsed.body));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> addMedia(Map<String, String> data, String path) async {
    String token = Preferences.getToken();
    String user_id = Preferences.getUserId();
    data['userid'] = user_id;
    data['token'] = token;
    //data['image'] = "null";
    //for multipartrequest
    var request = http.MultipartRequest('POST', Uri.parse(ADD_MEDIA));
    //for token
    request.headers.addAll({
      'Accept': 'application/json',
    });

    //for image and videos and files
    request.fields.assignAll(data);

    if (path.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath("image", path));
    }

    //for completeing the request
    var response = await request.send();

    //for getting and decoding the response into json format
    var responsed = await http.Response.fromStream(response);
    final responseData = json.decode(responsed.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateVenueMultipart(
      Map<String, String> data, String path) async {
    String token = Preferences.getToken();
    String user_id = Preferences.getUserId();
    data['userid'] = user_id;
    data['token'] = token;
    //data['image'] = "null";
    //for multipartrequest
    var request = http.MultipartRequest('POST', Uri.parse(UPDATE_VENUE));
    //for token
    request.headers.addAll({
      'Accept': 'application/json',
    });

    //for image and videos and files
    request.fields.assignAll(data);

    if (!path.startsWith("http")) {
      request.files.add(await http.MultipartFile.fromPath("image", path));
    }

    //for completeing the request
    var response = await request.send();

    //for getting and decoding the response into json format
    var responsed = await http.Response.fromStream(response);
    final responseData = json.decode(responsed.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<VenueList?> fetchVenues() async {
    String token = Preferences.getToken();
    String user_id = Preferences.getUserId();
    Map<String, String> data = {};
    data['userid'] = user_id;
    data['token'] = token;

    print(data);

    Map<String, String> headers = {
      'Accept': 'application/json',
    };
    http.Response res =
        await http.post(Uri.parse(FETCH_VENUES), headers: headers, body: data);
    print(jsonEncode(res.body));
    if (res.statusCode == 200) {
      VenueList datares = VenueList.fromJson(jsonDecode(res.body));
      if (datares.status == true) {
        return datares;
      }
    } else {
      AppUtills.showSnackBar("Error", "Something Went Wrong. Please try again.",
          isError: true);
    }
    return null;
  }

  Future<PackageListRes?> fetchPackage(String academy) async {
    String token = Preferences.getToken();
    String user_id = Preferences.getUserId();
    Map<String, String> data = {};
    data['userid'] = user_id;
    data['token'] = token;
    data['academy'] = academy;
    print(data);
    print(data);

    Map<String, String> headers = {
      'Accept': 'application/json',
    };
    http.Response res = await http.post(Uri.parse(FETCH_PACKAGES),
        headers: headers, body: data);
    print(jsonEncode(res.body));
    if (res.statusCode == 200) {
      PackageListRes datares = PackageListRes.fromJson(jsonDecode(res.body));
      if (datares.status == true) {
        return datares;
      }
    } else {
      AppUtills.showSnackBar("Error", "Something Went Wrong. Please try again.",
          isError: true);
    }
    return null;
  }

  Future<CmsResponse?> fetchCMS() async {
    String token = Preferences.getToken();
    String user_id = Preferences.getUserId();
    Map<String, String> data = {};
    data['userid'] = user_id;
    data['token'] = token;

    print(data);

    Map<String, String> headers = {
      'Accept': 'application/json',
    };
    http.Response res =
        await http.post(Uri.parse(FETCH_CMS), headers: headers, body: data);
    print(jsonEncode(res.body));
    if (res.statusCode == 200) {
      CmsResponse datares = CmsResponse.fromJson(jsonDecode(res.body));
      if (datares.status == true) {
        return datares;
      }
    } else {
      AppUtills.showSnackBar("Error", "Something Went Wrong. Please try again.",
          isError: true);
    }
    return null;
  }

  Future<AcademyResponse?> fetchAllAcademies() async {
    String token = Preferences.getToken();
    String user_id = Preferences.getUserId();
    Map<String, String> data = {};
    data['userid'] = user_id;
    data['token'] = token;

    Map<String, String> headers = {
      'Accept': 'application/json',
    };
    debugPrint(data.toString());

    http.Response res = await http.post(Uri.parse(FETCH_ACADEMIES),
        headers: headers, body: data);
    if (res.statusCode == 200) {
      AcademyResponse datares = AcademyResponse.fromJson(jsonDecode(res.body));
      if (datares.status == true) {
        return datares;
      }
    } else {
      AppUtills.showSnackBar("Error", "Something Went Wrong. Please try again.",
          isError: true);
    }
    return null;
  }

  Future<TournamentListResponse?> fetchTournaments() async {
    String token = Preferences.getToken();
    String user_id = Preferences.getUserId();
    Map<String, String> data = {};
    data['userid'] = user_id;
    data['token'] = token;

    Map<String, String> headers = {
      'Accept': 'application/json',
    };

    http.Response res = await http.post(Uri.parse(GET_TOURNAMENT),
        headers: headers, body: data);
    print(jsonEncode(res.body));
    if (res.statusCode == 200) {
      TournamentListResponse datares =
          TournamentListResponse.fromJson(jsonDecode(res.body));
      if (datares.status == true) {
        return datares;
      } else {
        /*   AppUtills.showSnackBar("Error",
            datares.message ?? "Something Went Wrong. Please try again.",
            isError: true);*/
      }
    }
    return null;
  }

  Future<ExperienceListResponse?> fetchExperiences() async {
    String token = Preferences.getToken();
    String user_id = Preferences.getUserId();
    Map<String, String> data = {};
    data['userid'] = user_id;
    data['token'] = token;

    Map<String, String> headers = {
      'Accept': 'application/json',
    };
    print(data.toString());
    http.Response res = await http.post(Uri.parse(GET_EXPERIENCE),
        headers: headers, body: data);
    print(jsonEncode(res.body));
    if (res.statusCode == 200) {
      ExperienceListResponse datares =
          ExperienceListResponse.fromJson(jsonDecode(res.body));
      if (datares.status == true) {
        return datares;
      } else {
        /* AppUtills.showSnackBar("Error",
            datares.message ?? "Something Went Wrong. Please try again.",
            isError: true);*/
      }
    }
    return null;
  }

  Future<FacilityListResponse?> fetchFacilities(String venue_id) async {
    String token = Preferences.getToken();
    String user_id = Preferences.getUserId();
    Map<String, String> data = {};
    data['userid'] = user_id;
    data['token'] = token;
    data['venue_id'] = venue_id;

    debugPrint(data.toString());
    Map<String, String> headers = {
      'Accept': 'application/json',
    };

    http.Response res = await http.post(Uri.parse(FETCH_FACILITY),
        headers: headers, body: data);
    print(jsonEncode(res.body));
    if (res.statusCode == 200) {
      FacilityListResponse datares =
          FacilityListResponse.fromJson(jsonDecode(res.body));
      if (datares.status == true) {
        return datares;
      } else {
        /* AppUtills.showSnackBar("Error",
            datares.message ?? "Something Went Wrong. Please try again.",
            isError: true);*/
      }
    }
    return null;
  }

  Future<MediaListResponse?> fetchMedia(String id) async {
    String token = Preferences.getToken();
    String user_id = Preferences.getUserId();
    Map<String, String> data = {};
    data['userid'] = user_id;
    data['token'] = token;
    data['post_id'] = id;
    data['id'] = id;
    Map<String, String> headers = {
      'Accept': 'application/json',
    };
    print(data);
    http.Response res =
        await http.post(Uri.parse(FETCH_MEDIA), headers: headers, body: data);
    print(jsonEncode(res.body));
    if (res.statusCode == 200) {
      MediaListResponse datares =
          MediaListResponse.fromJson(jsonDecode(res.body));
      if (datares.status == true) {
        return datares;
      }
    }
    return null;
  }

  Future<bool> deleteMedia(String id) async {
    String token = Preferences.getToken();
    String user_id = Preferences.getUserId();
    Map<String, String> data = {};
    data['userid'] = user_id;
    data['token'] = token;
    data['post_id'] = id;
    data['id'] = id;
    Map<String, String> headers = {
      'Accept': 'application/json',
    };
    http.Response res =
        await http.post(Uri.parse(DELETE_MEDIA), headers: headers, body: data);
    print(jsonEncode(res.body));

    if (res.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<AmenitiesListRes?> fetchAmenities() async {
    String token = Preferences.getToken();
    String user_id = Preferences.getUserId();
    Map<String, String> data = {};
    data['userid'] = user_id;
    data['token'] = token;

    Map<String, String> headers = {
      'Accept': 'application/json',
    };
    http.Response res = await http.post(Uri.parse(FETCH_AMENITIS),
        headers: headers, body: data);
    print(jsonEncode(res.body));
    if (res.statusCode == 200) {
      AmenitiesListRes datares =
          AmenitiesListRes.fromJson(jsonDecode(res.body));
      if (datares.status == true) {
        return datares;
      } else {
        AppUtills.showSnackBar("Error",
            datares.message ?? "Something Went Wrong. Please try again.",
            isError: true);
      }
    }
    return null;
  }

  Future<SportsResponse?> fetchSports() async {
    String token = Preferences.getToken();
    String user_id = Preferences.getUserId();
    Map<String, String> data = {};
    data['userid'] = user_id;
    data['token'] = token;

    Map<String, String> headers = {
      'Accept': 'application/json',
    };
    http.Response res =
        await http.post(Uri.parse(FETCH_SPORTS), headers: headers, body: data);
    print(jsonEncode(res.body));
    if (res.statusCode == 200) {
      SportsResponse datares = SportsResponse.fromJson(jsonDecode(res.body));
      if (datares.status == true) {
        return datares;
      } else {
        AppUtills.showSnackBar("Error",
            datares.message ?? "Something Went Wrong. Please try again.",
            isError: true);
      }
    }
    return null;
  }

  Future<SponsorListResponse?> fetchSponsors() async {
    String token = Preferences.getToken();
    String user_id = Preferences.getUserId();
    Map<String, String> data = {};
    data['userid'] = user_id;
    data['token'] = token;

    Map<String, String> headers = {
      'Accept': 'application/json',
    };
    http.Response res =
        await http.post(Uri.parse(FETCH_SPONSOR), headers: headers, body: data);
    print(jsonEncode(res.body));
    if (res.statusCode == 200) {
      SponsorListResponse datares =
          SponsorListResponse.fromJson(jsonDecode(res.body));
      if (datares.status == true) {
        return datares;
      } else {
        /* AppUtills.showSnackBar("Error",
            datares.message ?? "Something Went Wrong. Please try again.",
            isError: true);*/
      }
    }
    return null;
  }

  Future<SingleVenueDetails?> fetchSingleVenue(String id) async {
    String token = Preferences.getToken();
    String user_id = Preferences.getUserId();
    Map<String, String> data = {};
    data['userid'] = user_id;
    data['token'] = token;
    data['id'] = id;

    Map<String, String> headers = {
      'Accept': 'application/json',
    };
    http.Response res = await http.post(Uri.parse(FETCH_SINGLE_VENUE),
        headers: headers, body: data);
    print(jsonEncode(res.body));
    if (res.statusCode == 200) {
      SingleVenueDetails datares =
          SingleVenueDetails.fromJson(jsonDecode(res.body));
      if (datares.status == true) {
        return datares;
      } else {
        AppUtills.showSnackBar("Error",
            datares.message ?? "Something Went Wrong. Please try again.",
            isError: true);
      }
    }
    return null;
  }

  Future<String> getFcmToken() async {
    String user_id = Preferences.getUserId();

    var request = http.MultipartRequest('POST', Uri.parse(GET_FCM_TOKEN));
    request.fields['userid'] = user_id;

    var response = await request.send();

    var responsed = await http.Response.fromStream(response);
    print(jsonDecode(responsed.body));
    var res = jsonDecode(responsed.body);
    if (response.statusCode == 200) {
      return res["fcm_token"] ?? "";
    } else {
      return "";
    }
  }

  Future<String> updateFcmToken(String fcmToken) async {
    String token = Preferences.getToken();
    String user_id = Preferences.getUserId();
    String deviceId = await getId() ?? "0";

    var request = http.MultipartRequest('POST', Uri.parse(UPDATE_FCM_TOKEN));
    request.fields['userid'] = user_id;
    request.fields['fcm_token'] = fcmToken;
    request.fields['gcm_token'] = deviceId;
    request.fields['token'] = token;

    var response = await request.send();

    var responsed = await http.Response.fromStream(response);
    print(responsed.body);
    var res = jsonDecode(responsed.body);
    if (response.statusCode == 200) {
      return res["fcm_token"] ?? "";
    } else {
      return "";
    }
  }

  Future<bool> addFacility(Map<String, String> data, bool isUpdate) async {
    String token = Preferences.getToken();
    String user_id = Preferences.getUserId();
    data['userid'] = user_id;
    data['token'] = token;

    var request = http.MultipartRequest(
        'POST', Uri.parse(isUpdate ? UPDATE_FACILITY : ADD_FACILITY));
    request.headers.addAll({
      'Accept': 'application/json',
    });

    //for image and videos and files
    request.fields.assignAll(data);

    //for completeing the request
    var response = await request.send();

    //for getting and decoding the response into json format
    var responsed = await http.Response.fromStream(response);
    print(jsonEncode(responsed.body));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteProfile() async {
    String token = Preferences.getToken();
    String user_id = Preferences.getUserId();
    Map<String, String> data = {};
    data['userid'] = user_id;
    data['token'] = token;
    data['type'] = "2";
    var request = http.MultipartRequest('POST', Uri.parse(DELETE_PROFILE));
    request.headers.addAll({
      'Accept': 'application/json',
    });

    //for image and videos and files
    request.fields.assignAll(data);

    //for completeing the request
    var response = await request.send();

    //for getting and decoding the response into json format
    var responsed = await http.Response.fromStream(response);
    print(jsonEncode(responsed.body));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deletePackage(String id, {bool isAcademy = false}) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
    };
    Map<String, String> data = {};
    String token = Preferences.getToken();
    String user_id = Preferences.getUserId();
    data['userid'] = user_id;
    data['token'] = token;
    data['id'] = id;
    http.Response res = await http.post(
        Uri.parse(isAcademy ? DELETE_ACADEMY : DELETE_PACKAGE),
        headers: headers,
        body: data);

    if (res.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<FetchSlotsResponseModel?> fetchSlots(Map<String, String> data) async {
    String token = Preferences.getToken();
    String user_id = Preferences.getUserId();
    data['userid'] = user_id;
    data['token'] = token;

    Map<String, String> headers = {
      'Accept': 'application/json',
    };

    http.Response res = await http.post(Uri.parse(FETCH_VENU_SLOTS),
        headers: headers, body: data);
    if (res.statusCode == 200) {
      FetchSlotsResponseModel datares =
          FetchSlotsResponseModel.fromJson(jsonDecode(res.body));
      if (datares.status == true) {
        return datares;
      }
    } else {
      AppUtills.showSnackBar("Error", "Something Went Wrong. Please try again.",
          isError: true);
    }
    return null;
  }

  Future<AllOrdersResponse?> fetchOrders() async {
    String token = Preferences.getToken();
    String user_id = Preferences.getUserId();
    Map<String, String> data = {};
    data['userid'] = user_id;
    data['token'] = token;
    data["partner_id"] = user_id;

    print(data);

    Map<String, String> headers = {
      'Accept': 'application/json',
    };
    http.Response res =
        await http.post(Uri.parse(FETCH_ORDERS), headers: headers, body: data);
    AllOrdersResponse datares =
        AllOrdersResponse.fromJson(jsonDecode(res.body));

    /* AllOrdersResponse datares = AllOrdersResponse.fromJson(jsonDecode(
        "{
    "status": true,
    "message": "Order Details",
    "data": [
        {
            "id": "1",
            "user_id": "1",
            "partner_id": "2",
            "type": "1",
            "order_date": "2022-12-22 10:38:49",
            "facility_booking_id": "1",
            "session_id": null,
            "tournament_id": null,
            "amount": null,
            "transaction_id": "1",
            "experience_id": "1",
            "status": "1",
            "created_at": "2023-01-30 01:40:25",
            "updated_at": "0000-00-00 00:00:00",
            "facility": {
                "id": "1",
                "title": "Cricket",
                "venue_id": "1",
                "no_of_inventories": "3",
                "min_players": "5",
                "max_players": "11",
                "default_players": "5",
                "price_per_slot": "15",
                "opening_time": "17:00:00",
                "closing_time": "23:59:59",
                "available_24_hours": "1",
                "slot_length_hrs": "1",
                "slot_length_min": "30",
                "slot_frequency": "1",
                "activity": "false",
                "status": "1",
                "created_at": "2023-01-28 17:31:33",
                "updated_at": "2023-01-29 10:01:33"
            },
            "tournament": null,
            "experience": {
                "id": "1",
                "title": "Racing",
                "description": "description",
                "price": "12",
                "venue_id": "1",
                "user_id": "7",
                "address": "",
                "start_time": "",
                "image": "1711exp2.jpg",
                "status": "1",
                "created_at": "2023-01-24 20:50:52",
                "updated_at": "2023-01-28 16:05:29"
            },
            "user": {
                "id": "1",
                "name": "Qwerty",
                "email": "qwertty@gmail.com",
                "password": "e6e061838856bf47e1de730719fb2609",
                "phone": "9876543210",
                "type": "1",
                "image": null,
                "status": "1",
                "encrypt_password": null,
                "created_at": "2022-12-21 23:58:12",
                "updated_at": "0000-00-00 00:00:00"
            }
        },
        {
            "id": "2",
            "user_id": "1",
            "partner_id": "2",
            "type": "2",
            "order_date": "2022-12-22 10:38:49",
            "facility_booking_id": null,
            "session_id": "1",
            "tournament_id": null,
            "amount": null,
            "transaction_id": "2",
            "experience_id": null,
            "status": "1",
            "created_at": "2022-12-22 10:39:01",
            "updated_at": "0000-00-00 00:00:00",
            "academy": {
                "id": "3",
                "user_id": "1",
                "venue_id": "1",
                "name": "Priyanka",
                "address": "Test",
                "logo": "20230124230053-2023-01-24tbl_academy225808.jpg",
                "latitude": "30.7362900",
                "longitude": "76.7884000",
                "description": "Test",
                "contact_no": "098764321",
                "head_coach": "Test",
                "session_timings": "15",
                "week_days": "6",
                "price": "20000",
                "remarks_price": "244444",
                "skill_level": "Test",
                "academy_jersey": "Test",
                "capacity": "12",
                "remarks_current_capacity": "10",
                "session_plan": "132",
                "remarks_session_plan": "31",
                "age_group_of_students": "18",
                "remarks_students": "15",
                "equipment": "45",
                "remarks_on_equipment": "Test",
                "flood_lights": "12",
                "ground_size": "50x50",
                "person": "30",
                "coach_experience": "8",
                "no_of_assistent_coach": "5",
                "assistent_coach_name": "Coach",
                "feedbacks": "Test",
                "amenities_id": "2",
                "status": "0",
                "created_at": "0000-00-00 00:00:00",
                "updated_at": "0000-00-00 00:00:00"
            },
            "tournament": null,
            "experience": {
                "id": "1",
                "title": "Racing",
                "description": "description",
                "price": "12",
                "venue_id": "1",
                "user_id": "7",
                "address": "",
                "start_time": "",
                "image": "1711exp2.jpg",
                "status": "1",
                "created_at": "2023-01-24 20:50:52",
                "updated_at": "2023-01-28 16:05:29"
            },
            "user": {
                "id": "1",
                "name": "Qwerty",
                "email": "qwertty@gmail.com",
                "password": "e6e061838856bf47e1de730719fb2609",
                "phone": "9876543210",
                "type": "1",
                "image": null,
                "status": "1",
                "encrypt_password": null,
                "created_at": "2022-12-21 23:58:12",
                "updated_at": "0000-00-00 00:00:00"
            }
        },
        {
            "id": "3",
            "user_id": "1",
            "partner_id": "2",
            "type": "3",
            "order_date": "2022-12-22 10:38:49",
            "facility_booking_id": null,
            "session_id": null,
            "tournament_id": "1",
            "amount": null,
            "transaction_id": "3",
            "experience_id": null,
            "status": "1",
            "created_at": "2022-12-22 10:39:01",
            "updated_at": "0000-00-00 00:00:00",
            "tournament": {
                "id": "1",
                "user_id": "7",
                "academy_id": "2",
                "title": "Academy Tournaments",
                "no_of_tickets": "100",
                "tickets_left": null,
                "price": "100",
                "start_date": "0000-00-00 00:00:00",
                "end_date": "0000-00-00 00:00:00",
                "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                "type": "2",
                "image": "2747image_picker_B41E2C1A-BE90-4665-9442-EED986DC105A-11713-000001D530326DDC.jpg",
                "url": "-",
                "approved": "0",
                "status": "1",
                "created_at": "0000-00-00 00:00:00",
                "updated_at": "0000-00-00 00:00:00"
            },
            "experience": {
                "id": "1",
                "title": "Racing",
                "description": "description",
                "price": "12",
                "venue_id": "1",
                "user_id": "7",
                "address": "",
                "start_time": "",
                "image": "1711exp2.jpg",
                "status": "1",
                "created_at": "2023-01-24 20:50:52",
                "updated_at": "2023-01-28 16:05:29"
            },
            "user": {
                "id": "1",
                "name": "Qwerty",
                "email": "qwertty@gmail.com",
                "password": "e6e061838856bf47e1de730719fb2609",
                "phone": "9876543210",
                "type": "1",
                "image": null,
                "status": "1",
                "encrypt_password": null,
                "created_at": "2022-12-21 23:58:12",
                "updated_at": "0000-00-00 00:00:00"
            }
        },
        {
            "id": "5",
            "user_id": "1",
            "partner_id": "3",
            "type": "1",
            "order_date": "2023-01-27 00:00:00",
            "facility_booking_id": "5",
            "session_id": null,
            "tournament_id": null,
            "amount": "50",
            "transaction_id": null,
            "experience_id": null,
            "status": "2",
            "created_at": "2023-01-27 06:04:55",
            "updated_at": "0000-00-00 00:00:00",
            "facility": {
                "id": "1",
                "title": "Cricket",
                "venue_id": "1",
                "no_of_inventories": "3",
                "min_players": "5",
                "max_players": "11",
                "default_players": "5",
                "price_per_slot": "15",
                "opening_time": "17:00:00",
                "closing_time": "23:59:59",
                "available_24_hours": "1",
                "slot_length_hrs": "1",
                "slot_length_min": "30",
                "slot_frequency": "1",
                "activity": "false",
                "status": "1",
                "created_at": "2023-01-28 17:31:33",
                "updated_at": "2023-01-29 10:01:33"
            },
            "tournament": {
                "id": "1",
                "user_id": "7",
                "academy_id": "2",
                "title": "Academy Tournaments",
                "no_of_tickets": "100",
                "tickets_left": null,
                "price": "100",
                "start_date": "0000-00-00 00:00:00",
                "end_date": "0000-00-00 00:00:00",
                "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                "type": "2",
                "image": "2747image_picker_B41E2C1A-BE90-4665-9442-EED986DC105A-11713-000001D530326DDC.jpg",
                "url": "-",
                "approved": "0",
                "status": "1",
                "created_at": "0000-00-00 00:00:00",
                "updated_at": "0000-00-00 00:00:00"
            },
            "experience": {
                "id": "1",
                "title": "Racing",
                "description": "description",
                "price": "12",
                "venue_id": "1",
                "user_id": "7",
                "address": "",
                "start_time": "",
                "image": "1711exp2.jpg",
                "status": "1",
                "created_at": "2023-01-24 20:50:52",
                "updated_at": "2023-01-28 16:05:29"
            },
            "user": {
                "id": "1",
                "name": "Qwerty",
                "email": "qwertty@gmail.com",
                "password": "e6e061838856bf47e1de730719fb2609",
                "phone": "9876543210",
                "type": "1",
                "image": null,
                "status": "1",
                "encrypt_password": null,
                "created_at": "2022-12-21 23:58:12",
                "updated_at": "0000-00-00 00:00:00"
            }
        },
        {
            "id": "6",
            "user_id": "1",
            "partner_id": "3",
            "type": "1",
            "order_date": "2023-01-27 00:00:00",
            "facility_booking_id": "5",
            "session_id": null,
            "tournament_id": null,
            "amount": "50",
            "transaction_id": "6",
            "experience_id": null,
            "status": "1",
            "created_at": "2023-01-26 23:36:32",
            "updated_at": "0000-00-00 00:00:00",
            "facility": {
                "id": "1",
                "title": "Cricket",
                "venue_id": "1",
                "no_of_inventories": "3",
                "min_players": "5",
                "max_players": "11",
                "default_players": "5",
                "price_per_slot": "15",
                "opening_time": "17:00:00",
                "closing_time": "23:59:59",
                "available_24_hours": "1",
                "slot_length_hrs": "1",
                "slot_length_min": "30",
                "slot_frequency": "1",
                "activity": "false",
                "status": "1",
                "created_at": "2023-01-28 17:31:33",
                "updated_at": "2023-01-29 10:01:33"
            },
            "tournament": {
                "id": "1",
                "user_id": "7",
                "academy_id": "2",
                "title": "Academy Tournaments",
                "no_of_tickets": "100",
                "tickets_left": null,
                "price": "100",
                "start_date": "0000-00-00 00:00:00",
                "end_date": "0000-00-00 00:00:00",
                "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                "type": "2",
                "image": "2747image_picker_B41E2C1A-BE90-4665-9442-EED986DC105A-11713-000001D530326DDC.jpg",
                "url": "-",
                "approved": "0",
                "status": "1",
                "created_at": "0000-00-00 00:00:00",
                "updated_at": "0000-00-00 00:00:00"
            },
            "experience": {
                "id": "1",
                "title": "Racing",
                "description": "description",
                "price": "12",
                "venue_id": "1",
                "user_id": "7",
                "address": "",
                "start_time": "",
                "image": "1711exp2.jpg",
                "status": "1",
                "created_at": "2023-01-24 20:50:52",
                "updated_at": "2023-01-28 16:05:29"
            },
            "user": {
                "id": "1",
                "name": "Qwerty",
                "email": "qwertty@gmail.com",
                "password": "e6e061838856bf47e1de730719fb2609",
                "phone": "9876543210",
                "type": "1",
                "image": null,
                "status": "1",
                "encrypt_password": null,
                "created_at": "2022-12-21 23:58:12",
                "updated_at": "0000-00-00 00:00:00"
            }
        },
        {
            "id": "7",
            "user_id": "1",
            "partner_id": "3",
            "type": "1",
            "order_date": "2023-01-29 00:00:00",
            "facility_booking_id": "24",
            "session_id": null,
            "tournament_id": null,
            "amount": "50",
            "transaction_id": "7",
            "experience_id": null,
            "status": "1",
            "created_at": "2023-01-29 01:50:38",
            "updated_at": "0000-00-00 00:00:00",
            "facility": {
                "id": "1",
                "title": "Cricket",
                "venue_id": "1",
                "no_of_inventories": "3",
                "min_players": "5",
                "max_players": "11",
                "default_players": "5",
                "price_per_slot": "15",
                "opening_time": "17:00:00",
                "closing_time": "23:59:59",
                "available_24_hours": "1",
                "slot_length_hrs": "1",
                "slot_length_min": "30",
                "slot_frequency": "1",
                "activity": "false",
                "status": "1",
                "created_at": "2023-01-28 17:31:33",
                "updated_at": "2023-01-29 10:01:33"
            },
            "tournament": {
                "id": "1",
                "user_id": "7",
                "academy_id": "2",
                "title": "Academy Tournaments",
                "no_of_tickets": "100",
                "tickets_left": null,
                "price": "100",
                "start_date": "0000-00-00 00:00:00",
                "end_date": "0000-00-00 00:00:00",
                "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                "type": "2",
                "image": "2747image_picker_B41E2C1A-BE90-4665-9442-EED986DC105A-11713-000001D530326DDC.jpg",
                "url": "-",
                "approved": "0",
                "status": "1",
                "created_at": "0000-00-00 00:00:00",
                "updated_at": "0000-00-00 00:00:00"
            },
            "experience": {
                "id": "1",
                "title": "Racing",
                "description": "description",
                "price": "12",
                "venue_id": "1",
                "user_id": "7",
                "address": "",
                "start_time": "",
                "image": "1711exp2.jpg",
                "status": "1",
                "created_at": "2023-01-24 20:50:52",
                "updated_at": "2023-01-28 16:05:29"
            },
            "user": {
                "id": "1",
                "name": "Qwerty",
                "email": "qwertty@gmail.com",
                "password": "e6e061838856bf47e1de730719fb2609",
                "phone": "9876543210",
                "type": "1",
                "image": null,
                "status": "1",
                "encrypt_password": null,
                "created_at": "2022-12-21 23:58:12",
                "updated_at": "0000-00-00 00:00:00"
            }
        },
        {
            "id": "8",
            "user_id": "1",
            "partner_id": "3",
            "type": "1",
            "order_date": "2023-01-29 00:00:00",
            "facility_booking_id": "28",
            "session_id": null,
            "tournament_id": null,
            "amount": null,
            "transaction_id": null,
            "experience_id": null,
            "status": "2",
            "created_at": "2023-01-29 18:37:43",
            "updated_at": "0000-00-00 00:00:00",
            "facility": {
                "id": "1",
                "title": "Cricket",
                "venue_id": "1",
                "no_of_inventories": "3",
                "min_players": "5",
                "max_players": "11",
                "default_players": "5",
                "price_per_slot": "15",
                "opening_time": "17:00:00",
                "closing_time": "23:59:59",
                "available_24_hours": "1",
                "slot_length_hrs": "1",
                "slot_length_min": "30",
                "slot_frequency": "1",
                "activity": "false",
                "status": "1",
                "created_at": "2023-01-28 17:31:33",
                "updated_at": "2023-01-29 10:01:33"
            },
            "tournament": {
                "id": "1",
                "user_id": "7",
                "academy_id": "2",
                "title": "Academy Tournaments",
                "no_of_tickets": "100",
                "tickets_left": null,
                "price": "100",
                "start_date": "0000-00-00 00:00:00",
                "end_date": "0000-00-00 00:00:00",
                "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                "type": "2",
                "image": "2747image_picker_B41E2C1A-BE90-4665-9442-EED986DC105A-11713-000001D530326DDC.jpg",
                "url": "-",
                "approved": "0",
                "status": "1",
                "created_at": "0000-00-00 00:00:00",
                "updated_at": "0000-00-00 00:00:00"
            },
            "experience": {
                "id": "1",
                "title": "Racing",
                "description": "description",
                "price": "12",
                "venue_id": "1",
                "user_id": "7",
                "address": "",
                "start_time": "",
                "image": "1711exp2.jpg",
                "status": "1",
                "created_at": "2023-01-24 20:50:52",
                "updated_at": "2023-01-28 16:05:29"
            },
            "user": {
                "id": "1",
                "name": "Qwerty",
                "email": "qwertty@gmail.com",
                "password": "e6e061838856bf47e1de730719fb2609",
                "phone": "9876543210",
                "type": "1",
                "image": null,
                "status": "1",
                "encrypt_password": null,
                "created_at": "2022-12-21 23:58:12",
                "updated_at": "0000-00-00 00:00:00"
            }
        },
        {
            "id": "9",
            "user_id": "1",
            "partner_id": "3",
            "type": "1",
            "order_date": "2023-01-29 00:00:00",
            "facility_booking_id": "24",
            "session_id": null,
            "tournament_id": null,
            "amount": null,
            "transaction_id": null,
            "experience_id": null,
            "status": "2",
            "created_at": "2023-01-29 18:40:12",
            "updated_at": "0000-00-00 00:00:00",
            "facility": {
                "id": "1",
                "title": "Cricket",
                "venue_id": "1",
                "no_of_inventories": "3",
                "min_players": "5",
                "max_players": "11",
                "default_players": "5",
                "price_per_slot": "15",
                "opening_time": "17:00:00",
                "closing_time": "23:59:59",
                "available_24_hours": "1",
                "slot_length_hrs": "1",
                "slot_length_min": "30",
                "slot_frequency": "1",
                "activity": "false",
                "status": "1",
                "created_at": "2023-01-28 17:31:33",
                "updated_at": "2023-01-29 10:01:33"
            },
            "tournament": {
                "id": "1",
                "user_id": "7",
                "academy_id": "2",
                "title": "Academy Tournaments",
                "no_of_tickets": "100",
                "tickets_left": null,
                "price": "100",
                "start_date": "0000-00-00 00:00:00",
                "end_date": "0000-00-00 00:00:00",
                "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                "type": "2",
                "image": "2747image_picker_B41E2C1A-BE90-4665-9442-EED986DC105A-11713-000001D530326DDC.jpg",
                "url": "-",
                "approved": "0",
                "status": "1",
                "created_at": "0000-00-00 00:00:00",
                "updated_at": "0000-00-00 00:00:00"
            },
            "experience": {
                "id": "1",
                "title": "Racing",
                "description": "description",
                "price": "12",
                "venue_id": "1",
                "user_id": "7",
                "address": "",
                "start_time": "",
                "image": "1711exp2.jpg",
                "status": "1",
                "created_at": "2023-01-24 20:50:52",
                "updated_at": "2023-01-28 16:05:29"
            },
            "user": {
                "id": "1",
                "name": "Qwerty",
                "email": "qwertty@gmail.com",
                "password": "e6e061838856bf47e1de730719fb2609",
                "phone": "9876543210",
                "type": "1",
                "image": null,
                "status": "1",
                "encrypt_password": null,
                "created_at": "2022-12-21 23:58:12",
                "updated_at": "0000-00-00 00:00:00"
            }
        },
        {
            "id": "10",
            "user_id": "1",
            "partner_id": "3",
            "type": "1",
            "order_date": "2023-01-29 00:00:00",
            "facility_booking_id": "29",
            "session_id": null,
            "tournament_id": null,
            "amount": "15",
            "transaction_id": null,
            "experience_id": null,
            "status": "2",
            "created_at": "2023-01-29 18:41:39",
            "updated_at": "0000-00-00 00:00:00",
            "facility": {
                "id": "1",
                "title": "Cricket",
                "venue_id": "1",
                "no_of_inventories": "3",
                "min_players": "5",
                "max_players": "11",
                "default_players": "5",
                "price_per_slot": "15",
                "opening_time": "17:00:00",
                "closing_time": "23:59:59",
                "available_24_hours": "1",
                "slot_length_hrs": "1",
                "slot_length_min": "30",
                "slot_frequency": "1",
                "activity": "false",
                "status": "1",
                "created_at": "2023-01-28 17:31:33",
                "updated_at": "2023-01-29 10:01:33"
            },
            "tournament": {
                "id": "1",
                "user_id": "7",
                "academy_id": "2",
                "title": "Academy Tournaments",
                "no_of_tickets": "100",
                "tickets_left": null,
                "price": "100",
                "start_date": "0000-00-00 00:00:00",
                "end_date": "0000-00-00 00:00:00",
                "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                "type": "2",
                "image": "2747image_picker_B41E2C1A-BE90-4665-9442-EED986DC105A-11713-000001D530326DDC.jpg",
                "url": "-",
                "approved": "0",
                "status": "1",
                "created_at": "0000-00-00 00:00:00",
                "updated_at": "0000-00-00 00:00:00"
            },
            "experience": {
                "id": "1",
                "title": "Racing",
                "description": "description",
                "price": "12",
                "venue_id": "1",
                "user_id": "7",
                "address": "",
                "start_time": "",
                "image": "1711exp2.jpg",
                "status": "1",
                "created_at": "2023-01-24 20:50:52",
                "updated_at": "2023-01-28 16:05:29"
            },
            "user": {
                "id": "1",
                "name": "Qwerty",
                "email": "qwertty@gmail.com",
                "password": "e6e061838856bf47e1de730719fb2609",
                "phone": "9876543210",
                "type": "1",
                "image": null,
                "status": "1",
                "encrypt_password": null,
                "created_at": "2022-12-21 23:58:12",
                "updated_at": "0000-00-00 00:00:00"
            }
        },
        {
            "id": "11",
            "user_id": "1",
            "partner_id": "3",
            "type": "1",
            "order_date": "2023-01-29 00:00:00",
            "facility_booking_id": "24",
            "session_id": null,
            "tournament_id": null,
            "amount": "50",
            "transaction_id": "8",
            "experience_id": "2",
            "status": "1",
            "created_at": "2023-01-30 01:40:59",
            "updated_at": "0000-00-00 00:00:00",
            "facility": {
                "id": "1",
                "title": "Cricket",
                "venue_id": "1",
                "no_of_inventories": "3",
                "min_players": "5",
                "max_players": "11",
                "default_players": "5",
                "price_per_slot": "15",
                "opening_time": "17:00:00",
                "closing_time": "23:59:59",
                "available_24_hours": "1",
                "slot_length_hrs": "1",
                "slot_length_min": "30",
                "slot_frequency": "1",
                "activity": "false",
                "status": "1",
                "created_at": "2023-01-28 17:31:33",
                "updated_at": "2023-01-29 10:01:33"
            },
            "tournament": {
                "id": "1",
                "user_id": "7",
                "academy_id": "2",
                "title": "Academy Tournaments",
                "no_of_tickets": "100",
                "tickets_left": null,
                "price": "100",
                "start_date": "0000-00-00 00:00:00",
                "end_date": "0000-00-00 00:00:00",
                "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                "type": "2",
                "image": "2747image_picker_B41E2C1A-BE90-4665-9442-EED986DC105A-11713-000001D530326DDC.jpg",
                "url": "-",
                "approved": "0",
                "status": "1",
                "created_at": "0000-00-00 00:00:00",
                "updated_at": "0000-00-00 00:00:00"
            },
            "experience": null,
            "user": {
                "id": "1",
                "name": "Qwerty",
                "email": "qwertty@gmail.com",
                "password": "e6e061838856bf47e1de730719fb2609",
                "phone": "9876543210",
                "type": "1",
                "image": null,
                "status": "1",
                "encrypt_password": null,
                "created_at": "2022-12-21 23:58:12",
                "updated_at": "0000-00-00 00:00:00"
            }
        },
        {
            "id": "12",
            "user_id": "1",
            "partner_id": "3",
            "type": "1",
            "order_date": "2023-01-29 00:00:00",
            "facility_booking_id": "24",
            "session_id": null,
            "tournament_id": null,
            "amount": "50",
            "transaction_id": "9",
            "experience_id": null,
            "status": "1",
            "created_at": "2023-01-29 02:13:44",
            "updated_at": "0000-00-00 00:00:00",
            "facility": {
                "id": "1",
                "title": "Cricket",
                "venue_id": "1",
                "no_of_inventories": "3",
                "min_players": "5",
                "max_players": "11",
                "default_players": "5",
                "price_per_slot": "15",
                "opening_time": "17:00:00",
                "closing_time": "23:59:59",
                "available_24_hours": "1",
                "slot_length_hrs": "1",
                "slot_length_min": "30",
                "slot_frequency": "1",
                "activity": "false",
                "status": "1",
                "created_at": "2023-01-28 17:31:33",
                "updated_at": "2023-01-29 10:01:33"
            },
            "tournament": {
                "id": "1",
                "user_id": "7",
                "academy_id": "2",
                "title": "Academy Tournaments",
                "no_of_tickets": "100",
                "tickets_left": null,
                "price": "100",
                "start_date": "0000-00-00 00:00:00",
                "end_date": "0000-00-00 00:00:00",
                "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                "type": "2",
                "image": "2747image_picker_B41E2C1A-BE90-4665-9442-EED986DC105A-11713-000001D530326DDC.jpg",
                "url": "-",
                "approved": "0",
                "status": "1",
                "created_at": "0000-00-00 00:00:00",
                "updated_at": "0000-00-00 00:00:00"
            },
            "experience": null,
            "user": {
                "id": "1",
                "name": "Qwerty",
                "email": "qwertty@gmail.com",
                "password": "e6e061838856bf47e1de730719fb2609",
                "phone": "9876543210",
                "type": "1",
                "image": null,
                "status": "1",
                "encrypt_password": null,
                "created_at": "2022-12-21 23:58:12",
                "updated_at": "0000-00-00 00:00:00"
            }
        },
        {
            "id": "13",
            "user_id": "1",
            "partner_id": "3",
            "type": "1",
            "order_date": "2023-01-29 00:00:00",
            "facility_booking_id": "24",
            "session_id": null,
            "tournament_id": null,
            "amount": "50",
            "transaction_id": "10",
            "experience_id": null,
            "status": "1",
            "created_at": "2023-01-29 02:14:38",
            "updated_at": "0000-00-00 00:00:00",
            "facility": {
                "id": "1",
                "title": "Cricket",
                "venue_id": "1",
                "no_of_inventories": "3",
                "min_players": "5",
                "max_players": "11",
                "default_players": "5",
                "price_per_slot": "15",
                "opening_time": "17:00:00",
                "closing_time": "23:59:59",
                "available_24_hours": "1",
                "slot_length_hrs": "1",
                "slot_length_min": "30",
                "slot_frequency": "1",
                "activity": "false",
                "status": "1",
                "created_at": "2023-01-28 17:31:33",
                "updated_at": "2023-01-29 10:01:33"
            },
            "tournament": {
                "id": "1",
                "user_id": "7",
                "academy_id": "2",
                "title": "Academy Tournaments",
                "no_of_tickets": "100",
                "tickets_left": null,
                "price": "100",
                "start_date": "0000-00-00 00:00:00",
                "end_date": "0000-00-00 00:00:00",
                "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                "type": "2",
                "image": "2747image_picker_B41E2C1A-BE90-4665-9442-EED986DC105A-11713-000001D530326DDC.jpg",
                "url": "-",
                "approved": "0",
                "status": "1",
                "created_at": "0000-00-00 00:00:00",
                "updated_at": "0000-00-00 00:00:00"
            },
            "experience": null,
            "user": {
                "id": "1",
                "name": "Qwerty",
                "email": "qwertty@gmail.com",
                "password": "e6e061838856bf47e1de730719fb2609",
                "phone": "9876543210",
                "type": "1",
                "image": null,
                "status": "1",
                "encrypt_password": null,
                "created_at": "2022-12-21 23:58:12",
                "updated_at": "0000-00-00 00:00:00"
            }
        },
        {
            "id": "14",
            "user_id": "1",
            "partner_id": "3",
            "type": "1",
            "order_date": "2023-01-29 00:00:00",
            "facility_booking_id": "29",
            "session_id": null,
            "tournament_id": null,
            "amount": "50",
            "transaction_id": "11",
            "experience_id": null,
            "status": "1",
            "created_at": "2023-01-29 02:14:59",
            "updated_at": "0000-00-00 00:00:00",
            "facility": {
                "id": "1",
                "title": "Cricket",
                "venue_id": "1",
                "no_of_inventories": "3",
                "min_players": "5",
                "max_players": "11",
                "default_players": "5",
                "price_per_slot": "15",
                "opening_time": "17:00:00",
                "closing_time": "23:59:59",
                "available_24_hours": "1",
                "slot_length_hrs": "1",
                "slot_length_min": "30",
                "slot_frequency": "1",
                "activity": "false",
                "status": "1",
                "created_at": "2023-01-28 17:31:33",
                "updated_at": "2023-01-29 10:01:33"
            },
            "tournament": {
                "id": "1",
                "user_id": "7",
                "academy_id": "2",
                "title": "Academy Tournaments",
                "no_of_tickets": "100",
                "tickets_left": null,
                "price": "100",
                "start_date": "0000-00-00 00:00:00",
                "end_date": "0000-00-00 00:00:00",
                "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                "type": "2",
                "image": "2747image_picker_B41E2C1A-BE90-4665-9442-EED986DC105A-11713-000001D530326DDC.jpg",
                "url": "-",
                "approved": "0",
                "status": "1",
                "created_at": "0000-00-00 00:00:00",
                "updated_at": "0000-00-00 00:00:00"
            },
            "experience": null,
            "user": {
                "id": "1",
                "name": "Qwerty",
                "email": "qwertty@gmail.com",
                "password": "e6e061838856bf47e1de730719fb2609",
                "phone": "9876543210",
                "type": "1",
                "image": null,
                "status": "1",
                "encrypt_password": null,
                "created_at": "2022-12-21 23:58:12",
                "updated_at": "0000-00-00 00:00:00"
            }
        },
        {
            "id": "15",
            "user_id": "1",
            "partner_id": "3",
            "type": "1",
            "order_date": "2023-01-29 00:00:00",
            "facility_booking_id": "29",
            "session_id": null,
            "tournament_id": null,
            "amount": "50",
            "transaction_id": null,
            "experience_id": null,
            "status": "2",
            "created_at": "2023-01-29 18:45:07",
            "updated_at": "0000-00-00 00:00:00",
            "facility": {
                "id": "1",
                "title": "Cricket",
                "venue_id": "1",
                "no_of_inventories": "3",
                "min_players": "5",
                "max_players": "11",
                "default_players": "5",
                "price_per_slot": "15",
                "opening_time": "17:00:00",
                "closing_time": "23:59:59",
                "available_24_hours": "1",
                "slot_length_hrs": "1",
                "slot_length_min": "30",
                "slot_frequency": "1",
                "activity": "false",
                "status": "1",
                "created_at": "2023-01-28 17:31:33",
                "updated_at": "2023-01-29 10:01:33"
            },
            "tournament": {
                "id": "1",
                "user_id": "7",
                "academy_id": "2",
                "title": "Academy Tournaments",
                "no_of_tickets": "100",
                "tickets_left": null,
                "price": "100",
                "start_date": "0000-00-00 00:00:00",
                "end_date": "0000-00-00 00:00:00",
                "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                "type": "2",
                "image": "2747image_picker_B41E2C1A-BE90-4665-9442-EED986DC105A-11713-000001D530326DDC.jpg",
                "url": "-",
                "approved": "0",
                "status": "1",
                "created_at": "0000-00-00 00:00:00",
                "updated_at": "0000-00-00 00:00:00"
            },
            "experience": null,
            "user": {
                "id": "1",
                "name": "Qwerty",
                "email": "qwertty@gmail.com",
                "password": "e6e061838856bf47e1de730719fb2609",
                "phone": "9876543210",
                "type": "1",
                "image": null,
                "status": "1",
                "encrypt_password": null,
                "created_at": "2022-12-21 23:58:12",
                "updated_at": "0000-00-00 00:00:00"
            }
        },
        {
            "id": "16",
            "user_id": "1",
            "partner_id": "3",
            "type": "1",
            "order_date": "2023-01-29 00:00:00",
            "facility_booking_id": "31",
            "session_id": null,
            "tournament_id": null,
            "amount": "15",
            "transaction_id": "12",
            "experience_id": null,
            "status": "1",
            "created_at": "2023-01-29 02:16:52",
            "updated_at": "0000-00-00 00:00:00",
            "facility": {
                "id": "1",
                "title": "Cricket",
                "venue_id": "1",
                "no_of_inventories": "3",
                "min_players": "5",
                "max_players": "11",
                "default_players": "5",
                "price_per_slot": "15",
                "opening_time": "17:00:00",
                "closing_time": "23:59:59",
                "available_24_hours": "1",
                "slot_length_hrs": "1",
                "slot_length_min": "30",
                "slot_frequency": "1",
                "activity": "false",
                "status": "1",
                "created_at": "2023-01-28 17:31:33",
                "updated_at": "2023-01-29 10:01:33"
            },
            "tournament": {
                "id": "1",
                "user_id": "7",
                "academy_id": "2",
                "title": "Academy Tournaments",
                "no_of_tickets": "100",
                "tickets_left": null,
                "price": "100",
                "start_date": "0000-00-00 00:00:00",
                "end_date": "0000-00-00 00:00:00",
                "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                "type": "2",
                "image": "2747image_picker_B41E2C1A-BE90-4665-9442-EED986DC105A-11713-000001D530326DDC.jpg",
                "url": "-",
                "approved": "0",
                "status": "1",
                "created_at": "0000-00-00 00:00:00",
                "updated_at": "0000-00-00 00:00:00"
            },
            "experience": null,
            "user": {
                "id": "1",
                "name": "Qwerty",
                "email": "qwertty@gmail.com",
                "password": "e6e061838856bf47e1de730719fb2609",
                "phone": "9876543210",
                "type": "1",
                "image": null,
                "status": "1",
                "encrypt_password": null,
                "created_at": "2022-12-21 23:58:12",
                "updated_at": "0000-00-00 00:00:00"
            }
        },
        {
            "id": "17",
            "user_id": "1",
            "partner_id": "3",
            "type": "1",
            "order_date": "2023-01-29 00:00:00",
            "facility_booking_id": "32",
            "session_id": null,
            "tournament_id": null,
            "amount": "15",
            "transaction_id": "13",
            "experience_id": null,
            "status": "1",
            "created_at": "2023-01-29 02:17:59",
            "updated_at": "0000-00-00 00:00:00",
            "facility": {
                "id": "1",
                "title": "Cricket",
                "venue_id": "1",
                "no_of_inventories": "3",
                "min_players": "5",
                "max_players": "11",
                "default_players": "5",
                "price_per_slot": "15",
                "opening_time": "17:00:00",
                "closing_time": "23:59:59",
                "available_24_hours": "1",
                "slot_length_hrs": "1",
                "slot_length_min": "30",
                "slot_frequency": "1",
                "activity": "false",
                "status": "1",
                "created_at": "2023-01-28 17:31:33",
                "updated_at": "2023-01-29 10:01:33"
            },
            "tournament": {
                "id": "1",
                "user_id": "7",
                "academy_id": "2",
                "title": "Academy Tournaments",
                "no_of_tickets": "100",
                "tickets_left": null,
                "price": "100",
                "start_date": "0000-00-00 00:00:00",
                "end_date": "0000-00-00 00:00:00",
                "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                "type": "2",
                "image": "2747image_picker_B41E2C1A-BE90-4665-9442-EED986DC105A-11713-000001D530326DDC.jpg",
                "url": "-",
                "approved": "0",
                "status": "1",
                "created_at": "0000-00-00 00:00:00",
                "updated_at": "0000-00-00 00:00:00"
            },
            "experience": null,
            "user": {
                "id": "1",
                "name": "Qwerty",
                "email": "qwertty@gmail.com",
                "password": "e6e061838856bf47e1de730719fb2609",
                "phone": "9876543210",
                "type": "1",
                "image": null,
                "status": "1",
                "encrypt_password": null,
                "created_at": "2022-12-21 23:58:12",
                "updated_at": "0000-00-00 00:00:00"
            }
        },
        {
            "id": "18",
            "user_id": "1",
            "partner_id": "3",
            "type": "1",
            "order_date": "2023-01-29 00:00:00",
            "facility_booking_id": "33",
            "session_id": null,
            "tournament_id": null,
            "amount": "15",
            "transaction_id": "14",
            "experience_id": null,
            "status": "1",
            "created_at": "2023-01-29 02:20:23",
            "updated_at": "0000-00-00 00:00:00",
            "facility": {
                "id": "2",
                "title": "Footbal",
                "venue_id": "1",
                "no_of_inventories": "3",
                "min_players": "5",
                "max_players": "11",
                "default_players": "1",
                "price_per_slot": "15",
                "opening_time": "09:00:00",
                "closing_time": "08:00:00",
                "available_24_hours": "1",
                "slot_length_hrs": "10",
                "slot_length_min": "30",
                "slot_frequency": "124",
                "activity": "false",
                "status": "1",
                "created_at": "2023-01-25 12:23:12",
                "updated_at": "2023-01-25 18:02:11"
            },
            "tournament": {
                "id": "1",
                "user_id": "7",
                "academy_id": "2",
                "title": "Academy Tournaments",
                "no_of_tickets": "100",
                "tickets_left": null,
                "price": "100",
                "start_date": "0000-00-00 00:00:00",
                "end_date": "0000-00-00 00:00:00",
                "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                "type": "2",
                "image": "2747image_picker_B41E2C1A-BE90-4665-9442-EED986DC105A-11713-000001D530326DDC.jpg",
                "url": "-",
                "approved": "0",
                "status": "1",
                "created_at": "0000-00-00 00:00:00",
                "updated_at": "0000-00-00 00:00:00"
            },
            "experience": null,
            "user": {
                "id": "1",
                "name": "Qwerty",
                "email": "qwertty@gmail.com",
                "password": "e6e061838856bf47e1de730719fb2609",
                "phone": "9876543210",
                "type": "1",
                "image": null,
                "status": "1",
                "encrypt_password": null,
                "created_at": "2022-12-21 23:58:12",
                "updated_at": "0000-00-00 00:00:00"
            }
        },
        {
            "id": "19",
            "user_id": "1",
            "partner_id": "3",
            "type": "3",
            "order_date": "2023-01-29 00:00:00",
            "facility_booking_id": null,
            "session_id": null,
            "tournament_id": "4",
            "amount": "120",
            "transaction_id": "15",
            "experience_id": null,
            "status": "1",
            "created_at": "2023-01-29 02:58:36",
            "updated_at": "0000-00-00 00:00:00",
            "tournament": {
                "id": "4",
                "user_id": "30",
                "academy_id": "4",
                "title": "Cricket Tounament",
                "no_of_tickets": "50",
                "tickets_left": null,
                "price": "120",
                "start_date": null,
                "end_date": null,
                "description": "Come play and win",
                "type": "1",
                "image": "",
                "url": null,
                "approved": "0",
                "status": "1",
                "created_at": "0000-00-00 00:00:00",
                "updated_at": "0000-00-00 00:00:00"
            },
            "experience": null,
            "user": {
                "id": "1",
                "name": "Qwerty",
                "email": "qwertty@gmail.com",
                "password": "e6e061838856bf47e1de730719fb2609",
                "phone": "9876543210",
                "type": "1",
                "image": null,
                "status": "1",
                "encrypt_password": null,
                "created_at": "2022-12-21 23:58:12",
                "updated_at": "0000-00-00 00:00:00"
            }
        },
        {
            "id": "20",
            "user_id": "1",
            "partner_id": "3",
            "type": "4",
            "order_date": "2023-01-29 00:00:00",
            "facility_booking_id": null,
            "session_id": null,
            "tournament_id": null,
            "amount": "12",
            "transaction_id": "16",
            "experience_id": "1",
            "status": "1",
            "created_at": "2023-01-30 01:40:53",
            "updated_at": "0000-00-00 00:00:00",
            "tournament": {
                "id": "4",
                "user_id": "30",
                "academy_id": "4",
                "title": "Cricket Tounament",
                "no_of_tickets": "50",
                "tickets_left": null,
                "price": "120",
                "start_date": null,
                "end_date": null,
                "description": "Come play and win",
                "type": "1",
                "image": "",
                "url": null,
                "approved": "0",
                "status": "1",
                "created_at": "0000-00-00 00:00:00",
                "updated_at": "0000-00-00 00:00:00"
            },
            "experience": {
                "id": "1",
                "title": "Racing",
                "description": "description",
                "price": "12",
                "venue_id": "1",
                "user_id": "7",
                "address": "",
                "start_time": "",
                "image": "1711exp2.jpg",
                "status": "1",
                "created_at": "2023-01-24 20:50:52",
                "updated_at": "2023-01-28 16:05:29"
            },
            "user": {
                "id": "1",
                "name": "Qwerty",
                "email": "qwertty@gmail.com",
                "password": "e6e061838856bf47e1de730719fb2609",
                "phone": "9876543210",
                "type": "1",
                "image": null,
                "status": "1",
                "encrypt_password": null,
                "created_at": "2022-12-21 23:58:12",
                "updated_at": "0000-00-00 00:00:00"
            }
        }
    ]
}"));
 */
    print(jsonEncode(res.body));
    if (res.statusCode == 200) {
      if (datares.status == true) {
        return datares;
      }
    } else {
      AppUtills.showSnackBar("Error", "Something Went Wrong. Please try again.",
          isError: true);
    }
    return null;
  }
}
