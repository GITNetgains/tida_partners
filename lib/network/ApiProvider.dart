import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tida_partners/AppUtils.dart';
import 'package:tida_partners/network/responses/AllOrdersResponse.dart';
import 'package:tida_partners/network/responses/CMSresponse.dart';
import 'package:tida_partners/network/responses/LoginResponse.dart';
import 'package:tida_partners/network/responses/PackageListResponse.dart';
import 'package:tida_partners/network/responses/SlotResponse.dart';
import 'package:tida_partners/network/responses/TournamentListResponse.dart';
import 'package:tida_partners/network/responses/amenities_res.dart';
import 'package:tida_partners/network/responses/media_response.dart';
import 'package:tida_partners/utilss/SharedPref.dart';

import '../booking_slot/fetch_facility_slots_model.dart';
import 'api_constants.dart';
import 'responses/ExperienceList.dart';
import 'responses/SingleVenueDetails.dart';
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

    if (path.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath("image", path));
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
    debugPrint(data.toString());
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
      request.files.add(await http.MultipartFile.fromPath("logo", path));
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
        AppUtills.showSnackBar("Error",
            datares.message ?? "Something Went Wrong. Please try again.",
            isError: true);
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
    Map<String, String> headers = {
      'Accept': 'application/json',
    };
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

    print(data);

    Map<String, String> headers = {
      'Accept': 'application/json',
    };
    http.Response res =
        await http.post(Uri.parse(FETCH_ORDERS), headers: headers, body: data);
    AllOrdersResponse datares =
        AllOrdersResponse.fromJson(jsonDecode(res.body));
    // AllOrdersResponse datares = AllOrdersResponse.fromJson(jsonDecode("{\n    \"status\": true,\n    \"message\": \"Order Details\",\n    \"data\": [\n        {\n            \"id\": \"1\",\n            \"user_id\": \"1\",\n            \"partner_id\": \"2\",\n            \"type\": \"1\",\n            \"order_date\": \"2022-12-22 10:38:49\",\n            \"facility_booking_id\": \"1\",\n            \"session_id\": null,\n            \"tournament_id\": null,\n            \"amount\": null,\n            \"transaction_id\": \"1\",\n            \"experience_id\": \"1\",\n            \"status\": \"1\",\n            \"created_at\": \"2023-01-30 01:40:25\",\n            \"updated_at\": \"0000-00-00 00:00:00\",\n            \"facility\": {\n                \"id\": \"1\",\n                \"title\": \"Cricket\",\n                \"venue_id\": \"1\",\n                \"no_of_inventories\": \"3\",\n                \"min_players\": \"5\",\n                \"max_players\": \"11\",\n                \"default_players\": \"5\",\n                \"price_per_slot\": \"15\",\n                \"opening_time\": \"17:00:00\",\n                \"closing_time\": \"23:59:59\",\n                \"available_24_hours\": \"1\",\n                \"slot_length_hrs\": \"1\",\n                \"slot_length_min\": \"30\",\n                \"slot_frequency\": \"1\",\n                \"activity\": \"false\",\n                \"status\": \"1\",\n                \"created_at\": \"2023-01-28 17:31:33\",\n                \"updated_at\": \"2023-01-29 10:01:33\"\n            },\n            \"tournament\": null,\n            \"experience\": {\n                \"id\": \"1\",\n                \"title\": \"Racing\",\n                \"description\": \"description\",\n                \"price\": \"12\",\n                \"venue_id\": \"1\",\n                \"user_id\": \"7\",\n                \"address\": \"\",\n                \"start_time\": \"\",\n                \"image\": \"1711exp2.jpg\",\n                \"status\": \"1\",\n                \"created_at\": \"2023-01-24 20:50:52\",\n                \"updated_at\": \"2023-01-28 16:05:29\"\n            },\n            \"user\": {\n                \"id\": \"1\",\n                \"name\": \"Qwerty\",\n                \"email\": \"qwertty@gmail.com\",\n                \"password\": \"e6e061838856bf47e1de730719fb2609\",\n                \"phone\": \"9876543210\",\n                \"type\": \"1\",\n                \"image\": null,\n                \"status\": \"1\",\n                \"encrypt_password\": null,\n                \"created_at\": \"2022-12-21 23:58:12\",\n                \"updated_at\": \"0000-00-00 00:00:00\"\n            }\n        },\n        {\n            \"id\": \"2\",\n            \"user_id\": \"1\",\n            \"partner_id\": \"2\",\n            \"type\": \"2\",\n            \"order_date\": \"2022-12-22 10:38:49\",\n            \"facility_booking_id\": null,\n            \"session_id\": \"1\",\n            \"tournament_id\": null,\n            \"amount\": null,\n            \"transaction_id\": \"2\",\n            \"experience_id\": null,\n            \"status\": \"1\",\n            \"created_at\": \"2022-12-22 10:39:01\",\n            \"updated_at\": \"0000-00-00 00:00:00\",\n            \"academy\": {\n                \"id\": \"3\",\n                \"user_id\": \"1\",\n                \"venue_id\": \"1\",\n                \"name\": \"Priyanka\",\n                \"address\": \"Test\",\n                \"logo\": \"20230124230053-2023-01-24tbl_academy225808.jpg\",\n                \"latitude\": \"30.7362900\",\n                \"longitude\": \"76.7884000\",\n                \"description\": \"Test\",\n                \"contact_no\": \"098764321\",\n                \"head_coach\": \"Test\",\n                \"session_timings\": \"15\",\n                \"week_days\": \"6\",\n                \"price\": \"20000\",\n                \"remarks_price\": \"244444\",\n                \"skill_level\": \"Test\",\n                \"academy_jersey\": \"Test\",\n                \"capacity\": \"12\",\n                \"remarks_current_capacity\": \"10\",\n                \"session_plan\": \"132\",\n                \"remarks_session_plan\": \"31\",\n                \"age_group_of_students\": \"18\",\n                \"remarks_students\": \"15\",\n                \"equipment\": \"45\",\n                \"remarks_on_equipment\": \"Test\",\n                \"flood_lights\": \"12\",\n                \"ground_size\": \"50x50\",\n                \"person\": \"30\",\n                \"coach_experience\": \"8\",\n                \"no_of_assistent_coach\": \"5\",\n                \"assistent_coach_name\": \"Coach\",\n                \"feedbacks\": \"Test\",\n                \"amenities_id\": \"2\",\n                \"status\": \"0\",\n                \"created_at\": \"0000-00-00 00:00:00\",\n                \"updated_at\": \"0000-00-00 00:00:00\"\n            },\n            \"tournament\": null,\n            \"experience\": {\n                \"id\": \"1\",\n                \"title\": \"Racing\",\n                \"description\": \"description\",\n                \"price\": \"12\",\n                \"venue_id\": \"1\",\n                \"user_id\": \"7\",\n                \"address\": \"\",\n                \"start_time\": \"\",\n                \"image\": \"1711exp2.jpg\",\n                \"status\": \"1\",\n                \"created_at\": \"2023-01-24 20:50:52\",\n                \"updated_at\": \"2023-01-28 16:05:29\"\n            },\n            \"user\": {\n                \"id\": \"1\",\n                \"name\": \"Qwerty\",\n                \"email\": \"qwertty@gmail.com\",\n                \"password\": \"e6e061838856bf47e1de730719fb2609\",\n                \"phone\": \"9876543210\",\n                \"type\": \"1\",\n                \"image\": null,\n                \"status\": \"1\",\n                \"encrypt_password\": null,\n                \"created_at\": \"2022-12-21 23:58:12\",\n                \"updated_at\": \"0000-00-00 00:00:00\"\n            }\n        },\n        {\n            \"id\": \"3\",\n            \"user_id\": \"1\",\n            \"partner_id\": \"2\",\n            \"type\": \"3\",\n            \"order_date\": \"2022-12-22 10:38:49\",\n            \"facility_booking_id\": null,\n            \"session_id\": null,\n            \"tournament_id\": \"1\",\n            \"amount\": null,\n            \"transaction_id\": \"3\",\n            \"experience_id\": null,\n            \"status\": \"1\",\n            \"created_at\": \"2022-12-22 10:39:01\",\n            \"updated_at\": \"0000-00-00 00:00:00\",\n            \"tournament\": {\n                \"id\": \"1\",\n                \"user_id\": \"7\",\n                \"academy_id\": \"2\",\n                \"title\": \"Academy Tournaments\",\n                \"no_of_tickets\": \"100\",\n                \"tickets_left\": null,\n                \"price\": \"100\",\n                \"start_date\": \"0000-00-00 00:00:00\",\n                \"end_date\": \"0000-00-00 00:00:00\",\n                \"description\": \"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s\",\n                \"type\": \"2\",\n                \"image\": \"2747image_picker_B41E2C1A-BE90-4665-9442-EED986DC105A-11713-000001D530326DDC.jpg\",\n                \"url\": \"-\",\n                \"approved\": \"0\",\n                \"status\": \"1\",\n                \"created_at\": \"0000-00-00 00:00:00\",\n                \"updated_at\": \"0000-00-00 00:00:00\"\n            },\n            \"experience\": {\n                \"id\": \"1\",\n                \"title\": \"Racing\",\n                \"description\": \"description\",\n                \"price\": \"12\",\n                \"venue_id\": \"1\",\n                \"user_id\": \"7\",\n                \"address\": \"\",\n                \"start_time\": \"\",\n                \"image\": \"1711exp2.jpg\",\n                \"status\": \"1\",\n                \"created_at\": \"2023-01-24 20:50:52\",\n                \"updated_at\": \"2023-01-28 16:05:29\"\n            },\n            \"user\": {\n                \"id\": \"1\",\n                \"name\": \"Qwerty\",\n                \"email\": \"qwertty@gmail.com\",\n                \"password\": \"e6e061838856bf47e1de730719fb2609\",\n                \"phone\": \"9876543210\",\n                \"type\": \"1\",\n                \"image\": null,\n                \"status\": \"1\",\n                \"encrypt_password\": null,\n                \"created_at\": \"2022-12-21 23:58:12\",\n                \"updated_at\": \"0000-00-00 00:00:00\"\n            }\n        },\n        {\n            \"id\": \"5\",\n            \"user_id\": \"1\",\n            \"partner_id\": \"3\",\n            \"type\": \"1\",\n            \"order_date\": \"2023-01-27 00:00:00\",\n            \"facility_booking_id\": \"5\",\n            \"session_id\": null,\n            \"tournament_id\": null,\n            \"amount\": \"50\",\n            \"transaction_id\": null,\n            \"experience_id\": null,\n            \"status\": \"2\",\n            \"created_at\": \"2023-01-27 06:04:55\",\n            \"updated_at\": \"0000-00-00 00:00:00\",\n            \"facility\": {\n                \"id\": \"1\",\n                \"title\": \"Cricket\",\n                \"venue_id\": \"1\",\n                \"no_of_inventories\": \"3\",\n                \"min_players\": \"5\",\n                \"max_players\": \"11\",\n                \"default_players\": \"5\",\n                \"price_per_slot\": \"15\",\n                \"opening_time\": \"17:00:00\",\n                \"closing_time\": \"23:59:59\",\n                \"available_24_hours\": \"1\",\n                \"slot_length_hrs\": \"1\",\n                \"slot_length_min\": \"30\",\n                \"slot_frequency\": \"1\",\n                \"activity\": \"false\",\n                \"status\": \"1\",\n                \"created_at\": \"2023-01-28 17:31:33\",\n                \"updated_at\": \"2023-01-29 10:01:33\"\n            },\n            \"tournament\": {\n                \"id\": \"1\",\n                \"user_id\": \"7\",\n                \"academy_id\": \"2\",\n                \"title\": \"Academy Tournaments\",\n                \"no_of_tickets\": \"100\",\n                \"tickets_left\": null,\n                \"price\": \"100\",\n                \"start_date\": \"0000-00-00 00:00:00\",\n                \"end_date\": \"0000-00-00 00:00:00\",\n                \"description\": \"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s\",\n                \"type\": \"2\",\n                \"image\": \"2747image_picker_B41E2C1A-BE90-4665-9442-EED986DC105A-11713-000001D530326DDC.jpg\",\n                \"url\": \"-\",\n                \"approved\": \"0\",\n                \"status\": \"1\",\n                \"created_at\": \"0000-00-00 00:00:00\",\n                \"updated_at\": \"0000-00-00 00:00:00\"\n            },\n            \"experience\": {\n                \"id\": \"1\",\n                \"title\": \"Racing\",\n                \"description\": \"description\",\n                \"price\": \"12\",\n                \"venue_id\": \"1\",\n                \"user_id\": \"7\",\n                \"address\": \"\",\n                \"start_time\": \"\",\n                \"image\": \"1711exp2.jpg\",\n                \"status\": \"1\",\n                \"created_at\": \"2023-01-24 20:50:52\",\n                \"updated_at\": \"2023-01-28 16:05:29\"\n            },\n            \"user\": {\n                \"id\": \"1\",\n                \"name\": \"Qwerty\",\n                \"email\": \"qwertty@gmail.com\",\n                \"password\": \"e6e061838856bf47e1de730719fb2609\",\n                \"phone\": \"9876543210\",\n                \"type\": \"1\",\n                \"image\": null,\n                \"status\": \"1\",\n                \"encrypt_password\": null,\n                \"created_at\": \"2022-12-21 23:58:12\",\n                \"updated_at\": \"0000-00-00 00:00:00\"\n            }\n        },\n        {\n            \"id\": \"6\",\n            \"user_id\": \"1\",\n            \"partner_id\": \"3\",\n            \"type\": \"1\",\n            \"order_date\": \"2023-01-27 00:00:00\",\n            \"facility_booking_id\": \"5\",\n            \"session_id\": null,\n            \"tournament_id\": null,\n            \"amount\": \"50\",\n            \"transaction_id\": \"6\",\n            \"experience_id\": null,\n            \"status\": \"1\",\n            \"created_at\": \"2023-01-26 23:36:32\",\n            \"updated_at\": \"0000-00-00 00:00:00\",\n            \"facility\": {\n                \"id\": \"1\",\n                \"title\": \"Cricket\",\n                \"venue_id\": \"1\",\n                \"no_of_inventories\": \"3\",\n                \"min_players\": \"5\",\n                \"max_players\": \"11\",\n                \"default_players\": \"5\",\n                \"price_per_slot\": \"15\",\n                \"opening_time\": \"17:00:00\",\n                \"closing_time\": \"23:59:59\",\n                \"available_24_hours\": \"1\",\n                \"slot_length_hrs\": \"1\",\n                \"slot_length_min\": \"30\",\n                \"slot_frequency\": \"1\",\n                \"activity\": \"false\",\n                \"status\": \"1\",\n                \"created_at\": \"2023-01-28 17:31:33\",\n                \"updated_at\": \"2023-01-29 10:01:33\"\n            },\n            \"tournament\": {\n                \"id\": \"1\",\n                \"user_id\": \"7\",\n                \"academy_id\": \"2\",\n                \"title\": \"Academy Tournaments\",\n                \"no_of_tickets\": \"100\",\n                \"tickets_left\": null,\n                \"price\": \"100\",\n                \"start_date\": \"0000-00-00 00:00:00\",\n                \"end_date\": \"0000-00-00 00:00:00\",\n                \"description\": \"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s\",\n                \"type\": \"2\",\n                \"image\": \"2747image_picker_B41E2C1A-BE90-4665-9442-EED986DC105A-11713-000001D530326DDC.jpg\",\n                \"url\": \"-\",\n                \"approved\": \"0\",\n                \"status\": \"1\",\n                \"created_at\": \"0000-00-00 00:00:00\",\n                \"updated_at\": \"0000-00-00 00:00:00\"\n            },\n            \"experience\": {\n                \"id\": \"1\",\n                \"title\": \"Racing\",\n                \"description\": \"description\",\n                \"price\": \"12\",\n                \"venue_id\": \"1\",\n                \"user_id\": \"7\",\n                \"address\": \"\",\n                \"start_time\": \"\",\n                \"image\": \"1711exp2.jpg\",\n                \"status\": \"1\",\n                \"created_at\": \"2023-01-24 20:50:52\",\n                \"updated_at\": \"2023-01-28 16:05:29\"\n            },\n            \"user\": {\n                \"id\": \"1\",\n                \"name\": \"Qwerty\",\n                \"email\": \"qwertty@gmail.com\",\n                \"password\": \"e6e061838856bf47e1de730719fb2609\",\n                \"phone\": \"9876543210\",\n                \"type\": \"1\",\n                \"image\": null,\n                \"status\": \"1\",\n                \"encrypt_password\": null,\n                \"created_at\": \"2022-12-21 23:58:12\",\n                \"updated_at\": \"0000-00-00 00:00:00\"\n            }\n        },\n        {\n            \"id\": \"7\",\n            \"user_id\": \"1\",\n            \"partner_id\": \"3\",\n            \"type\": \"1\",\n            \"order_date\": \"2023-01-29 00:00:00\",\n            \"facility_booking_id\": \"24\",\n            \"session_id\": null,\n            \"tournament_id\": null,\n            \"amount\": \"50\",\n            \"transaction_id\": \"7\",\n            \"experience_id\": null,\n            \"status\": \"1\",\n            \"created_at\": \"2023-01-29 01:50:38\",\n            \"updated_at\": \"0000-00-00 00:00:00\",\n            \"facility\": {\n                \"id\": \"1\",\n                \"title\": \"Cricket\",\n                \"venue_id\": \"1\",\n                \"no_of_inventories\": \"3\",\n                \"min_players\": \"5\",\n                \"max_players\": \"11\",\n                \"default_players\": \"5\",\n                \"price_per_slot\": \"15\",\n                \"opening_time\": \"17:00:00\",\n                \"closing_time\": \"23:59:59\",\n                \"available_24_hours\": \"1\",\n                \"slot_length_hrs\": \"1\",\n                \"slot_length_min\": \"30\",\n                \"slot_frequency\": \"1\",\n                \"activity\": \"false\",\n                \"status\": \"1\",\n                \"created_at\": \"2023-01-28 17:31:33\",\n                \"updated_at\": \"2023-01-29 10:01:33\"\n            },\n            \"tournament\": {\n                \"id\": \"1\",\n                \"user_id\": \"7\",\n                \"academy_id\": \"2\",\n                \"title\": \"Academy Tournaments\",\n                \"no_of_tickets\": \"100\",\n                \"tickets_left\": null,\n                \"price\": \"100\",\n                \"start_date\": \"0000-00-00 00:00:00\",\n                \"end_date\": \"0000-00-00 00:00:00\",\n                \"description\": \"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s\",\n                \"type\": \"2\",\n                \"image\": \"2747image_picker_B41E2C1A-BE90-4665-9442-EED986DC105A-11713-000001D530326DDC.jpg\",\n                \"url\": \"-\",\n                \"approved\": \"0\",\n                \"status\": \"1\",\n                \"created_at\": \"0000-00-00 00:00:00\",\n                \"updated_at\": \"0000-00-00 00:00:00\"\n            },\n            \"experience\": {\n                \"id\": \"1\",\n                \"title\": \"Racing\",\n                \"description\": \"description\",\n                \"price\": \"12\",\n                \"venue_id\": \"1\",\n                \"user_id\": \"7\",\n                \"address\": \"\",\n                \"start_time\": \"\",\n                \"image\": \"1711exp2.jpg\",\n                \"status\": \"1\",\n                \"created_at\": \"2023-01-24 20:50:52\",\n                \"updated_at\": \"2023-01-28 16:05:29\"\n            },\n            \"user\": {\n                \"id\": \"1\",\n                \"name\": \"Qwerty\",\n                \"email\": \"qwertty@gmail.com\",\n                \"password\": \"e6e061838856bf47e1de730719fb2609\",\n                \"phone\": \"9876543210\",\n                \"type\": \"1\",\n                \"image\": null,\n                \"status\": \"1\",\n                \"encrypt_password\": null,\n                \"created_at\": \"2022-12-21 23:58:12\",\n                \"updated_at\": \"0000-00-00 00:00:00\"\n            }\n        },\n        {\n            \"id\": \"8\",\n            \"user_id\": \"1\",\n            \"partner_id\": \"3\",\n            \"type\": \"1\",\n            \"order_date\": \"2023-01-29 00:00:00\",\n            \"facility_booking_id\": \"28\",\n            \"session_id\": null,\n            \"tournament_id\": null,\n            \"amount\": null,\n            \"transaction_id\": null,\n            \"experience_id\": null,\n            \"status\": \"2\",\n            \"created_at\": \"2023-01-29 18:37:43\",\n            \"updated_at\": \"0000-00-00 00:00:00\",\n            \"facility\": {\n                \"id\": \"1\",\n                \"title\": \"Cricket\",\n                \"venue_id\": \"1\",\n                \"no_of_inventories\": \"3\",\n                \"min_players\": \"5\",\n                \"max_players\": \"11\",\n                \"default_players\": \"5\",\n                \"price_per_slot\": \"15\",\n                \"opening_time\": \"17:00:00\",\n                \"closing_time\": \"23:59:59\",\n                \"available_24_hours\": \"1\",\n                \"slot_length_hrs\": \"1\",\n                \"slot_length_min\": \"30\",\n                \"slot_frequency\": \"1\",\n                \"activity\": \"false\",\n                \"status\": \"1\",\n                \"created_at\": \"2023-01-28 17:31:33\",\n                \"updated_at\": \"2023-01-29 10:01:33\"\n            },\n            \"tournament\": {\n                \"id\": \"1\",\n                \"user_id\": \"7\",\n                \"academy_id\": \"2\",\n                \"title\": \"Academy Tournaments\",\n                \"no_of_tickets\": \"100\",\n                \"tickets_left\": null,\n                \"price\": \"100\",\n                \"start_date\": \"0000-00-00 00:00:00\",\n                \"end_date\": \"0000-00-00 00:00:00\",\n                \"description\": \"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s\",\n                \"type\": \"2\",\n                \"image\": \"2747image_picker_B41E2C1A-BE90-4665-9442-EED986DC105A-11713-000001D530326DDC.jpg\",\n                \"url\": \"-\",\n                \"approved\": \"0\",\n                \"status\": \"1\",\n                \"created_at\": \"0000-00-00 00:00:00\",\n                \"updated_at\": \"0000-00-00 00:00:00\"\n            },\n            \"experience\": {\n                \"id\": \"1\",\n                \"title\": \"Racing\",\n                \"description\": \"description\",\n                \"price\": \"12\",\n                \"venue_id\": \"1\",\n                \"user_id\": \"7\",\n                \"address\": \"\",\n                \"start_time\": \"\",\n                \"image\": \"1711exp2.jpg\",\n                \"status\": \"1\",\n                \"created_at\": \"2023-01-24 20:50:52\",\n                \"updated_at\": \"2023-01-28 16:05:29\"\n            },\n            \"user\": {\n                \"id\": \"1\",\n                \"name\": \"Qwerty\",\n                \"email\": \"qwertty@gmail.com\",\n                \"password\": \"e6e061838856bf47e1de730719fb2609\",\n                \"phone\": \"9876543210\",\n                \"type\": \"1\",\n                \"image\": null,\n                \"status\": \"1\",\n                \"encrypt_password\": null,\n                \"created_at\": \"2022-12-21 23:58:12\",\n                \"updated_at\": \"0000-00-00 00:00:00\"\n            }\n        },\n        {\n            \"id\": \"9\",\n            \"user_id\": \"1\",\n            \"partner_id\": \"3\",\n            \"type\": \"1\",\n            \"order_date\": \"2023-01-29 00:00:00\",\n            \"facility_booking_id\": \"24\",\n            \"session_id\": null,\n            \"tournament_id\": null,\n            \"amount\": null,\n            \"transaction_id\": null,\n            \"experience_id\": null,\n            \"status\": \"2\",\n            \"created_at\": \"2023-01-29 18:40:12\",\n            \"updated_at\": \"0000-00-00 00:00:00\",\n            \"facility\": {\n                \"id\": \"1\",\n                \"title\": \"Cricket\",\n                \"venue_id\": \"1\",\n                \"no_of_inventories\": \"3\",\n                \"min_players\": \"5\",\n                \"max_players\": \"11\",\n                \"default_players\": \"5\",\n                \"price_per_slot\": \"15\",\n                \"opening_time\": \"17:00:00\",\n                \"closing_time\": \"23:59:59\",\n                \"available_24_hours\": \"1\",\n                \"slot_length_hrs\": \"1\",\n                \"slot_length_min\": \"30\",\n                \"slot_frequency\": \"1\",\n                \"activity\": \"false\",\n                \"status\": \"1\",\n                \"created_at\": \"2023-01-28 17:31:33\",\n                \"updated_at\": \"2023-01-29 10:01:33\"\n            },\n            \"tournament\": {\n                \"id\": \"1\",\n                \"user_id\": \"7\",\n                \"academy_id\": \"2\",\n                \"title\": \"Academy Tournaments\",\n                \"no_of_tickets\": \"100\",\n                \"tickets_left\": null,\n                \"price\": \"100\",\n                \"start_date\": \"0000-00-00 00:00:00\",\n                \"end_date\": \"0000-00-00 00:00:00\",\n                \"description\": \"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s\",\n                \"type\": \"2\",\n                \"image\": \"2747image_picker_B41E2C1A-BE90-4665-9442-EED986DC105A-11713-000001D530326DDC.jpg\",\n                \"url\": \"-\",\n                \"approved\": \"0\",\n                \"status\": \"1\",\n                \"created_at\": \"0000-00-00 00:00:00\",\n                \"updated_at\": \"0000-00-00 00:00:00\"\n            },\n            \"experience\": {\n                \"id\": \"1\",\n                \"title\": \"Racing\",\n                \"description\": \"description\",\n                \"price\": \"12\",\n                \"venue_id\": \"1\",\n                \"user_id\": \"7\",\n                \"address\": \"\",\n                \"start_time\": \"\",\n                \"image\": \"1711exp2.jpg\",\n                \"status\": \"1\",\n                \"created_at\": \"2023-01-24 20:50:52\",\n                \"updated_at\": \"2023-01-28 16:05:29\"\n            },\n            \"user\": {\n                \"id\": \"1\",\n                \"name\": \"Qwerty\",\n                \"email\": \"qwertty@gmail.com\",\n                \"password\": \"e6e061838856bf47e1de730719fb2609\",\n                \"phone\": \"9876543210\",\n                \"type\": \"1\",\n                \"image\": null,\n                \"status\": \"1\",\n                \"encrypt_password\": null,\n                \"created_at\": \"2022-12-21 23:58:12\",\n                \"updated_at\": \"0000-00-00 00:00:00\"\n            }\n        },\n        {\n            \"id\": \"10\",\n            \"user_id\": \"1\",\n            \"partner_id\": \"3\",\n            \"type\": \"1\",\n            \"order_date\": \"2023-01-29 00:00:00\",\n            \"facility_booking_id\": \"29\",\n            \"session_id\": null,\n            \"tournament_id\": null,\n            \"amount\": \"15\",\n            \"transaction_id\": null,\n            \"experience_id\": null,\n            \"status\": \"2\",\n            \"created_at\": \"2023-01-29 18:41:39\",\n            \"updated_at\": \"0000-00-00 00:00:00\",\n            \"facility\": {\n                \"id\": \"1\",\n                \"title\": \"Cricket\",\n                \"venue_id\": \"1\",\n                \"no_of_inventories\": \"3\",\n                \"min_players\": \"5\",\n                \"max_players\": \"11\",\n                \"default_players\": \"5\",\n                \"price_per_slot\": \"15\",\n                \"opening_time\": \"17:00:00\",\n                \"closing_time\": \"23:59:59\",\n                \"available_24_hours\": \"1\",\n                \"slot_length_hrs\": \"1\",\n                \"slot_length_min\": \"30\",\n                \"slot_frequency\": \"1\",\n                \"activity\": \"false\",\n                \"status\": \"1\",\n                \"created_at\": \"2023-01-28 17:31:33\",\n                \"updated_at\": \"2023-01-29 10:01:33\"\n            },\n            \"tournament\": {\n                \"id\": \"1\",\n                \"user_id\": \"7\",\n                \"academy_id\": \"2\",\n                \"title\": \"Academy Tournaments\",\n                \"no_of_tickets\": \"100\",\n                \"tickets_left\": null,\n                \"price\": \"100\",\n                \"start_date\": \"0000-00-00 00:00:00\",\n                \"end_date\": \"0000-00-00 00:00:00\",\n                \"description\": \"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s\",\n                \"type\": \"2\",\n                \"image\": \"2747image_picker_B41E2C1A-BE90-4665-9442-EED986DC105A-11713-000001D530326DDC.jpg\",\n                \"url\": \"-\",\n                \"approved\": \"0\",\n                \"status\": \"1\",\n                \"created_at\": \"0000-00-00 00:00:00\",\n                \"updated_at\": \"0000-00-00 00:00:00\"\n            },\n            \"experience\": {\n                \"id\": \"1\",\n                \"title\": \"Racing\",\n                \"description\": \"description\",\n                \"price\": \"12\",\n                \"venue_id\": \"1\",\n                \"user_id\": \"7\",\n                \"address\": \"\",\n                \"start_time\": \"\",\n                \"image\": \"1711exp2.jpg\",\n                \"status\": \"1\",\n                \"created_at\": \"2023-01-24 20:50:52\",\n                \"updated_at\": \"2023-01-28 16:05:29\"\n            },\n            \"user\": {\n                \"id\": \"1\",\n                \"name\": \"Qwerty\",\n                \"email\": \"qwertty@gmail.com\",\n                \"password\": \"e6e061838856bf47e1de730719fb2609\",\n                \"phone\": \"9876543210\",\n                \"type\": \"1\",\n                \"image\": null,\n                \"status\": \"1\",\n                \"encrypt_password\": null,\n                \"created_at\": \"2022-12-21 23:58:12\",\n                \"updated_at\": \"0000-00-00 00:00:00\"\n            }\n        },\n        {\n            \"id\": \"11\",\n            \"user_id\": \"1\",\n            \"partner_id\": \"3\",\n            \"type\": \"1\",\n            \"order_date\": \"2023-01-29 00:00:00\",\n            \"facility_booking_id\": \"24\",\n            \"session_id\": null,\n            \"tournament_id\": null,\n            \"amount\": \"50\",\n            \"transaction_id\": \"8\",\n            \"experience_id\": \"2\",\n            \"status\": \"1\",\n            \"created_at\": \"2023-01-30 01:40:59\",\n            \"updated_at\": \"0000-00-00 00:00:00\",\n            \"facility\": {\n                \"id\": \"1\",\n                \"title\": \"Cricket\",\n                \"venue_id\": \"1\",\n                \"no_of_inventories\": \"3\",\n                \"min_players\": \"5\",\n                \"max_players\": \"11\",\n                \"default_players\": \"5\",\n                \"price_per_slot\": \"15\",\n                \"opening_time\": \"17:00:00\",\n                \"closing_time\": \"23:59:59\",\n                \"available_24_hours\": \"1\",\n                \"slot_length_hrs\": \"1\",\n                \"slot_length_min\": \"30\",\n                \"slot_frequency\": \"1\",\n                \"activity\": \"false\",\n                \"status\": \"1\",\n                \"created_at\": \"2023-01-28 17:31:33\",\n                \"updated_at\": \"2023-01-29 10:01:33\"\n            },\n            \"tournament\": {\n                \"id\": \"1\",\n                \"user_id\": \"7\",\n                \"academy_id\": \"2\",\n                \"title\": \"Academy Tournaments\",\n                \"no_of_tickets\": \"100\",\n                \"tickets_left\": null,\n                \"price\": \"100\",\n                \"start_date\": \"0000-00-00 00:00:00\",\n                \"end_date\": \"0000-00-00 00:00:00\",\n                \"description\": \"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s\",\n                \"type\": \"2\",\n                \"image\": \"2747image_picker_B41E2C1A-BE90-4665-9442-EED986DC105A-11713-000001D530326DDC.jpg\",\n                \"url\": \"-\",\n                \"approved\": \"0\",\n                \"status\": \"1\",\n                \"created_at\": \"0000-00-00 00:00:00\",\n                \"updated_at\": \"0000-00-00 00:00:00\"\n            },\n            \"experience\": null,\n            \"user\": {\n                \"id\": \"1\",\n                \"name\": \"Qwerty\",\n                \"email\": \"qwertty@gmail.com\",\n                \"password\": \"e6e061838856bf47e1de730719fb2609\",\n                \"phone\": \"9876543210\",\n                \"type\": \"1\",\n                \"image\": null,\n                \"status\": \"1\",\n                \"encrypt_password\": null,\n                \"created_at\": \"2022-12-21 23:58:12\",\n                \"updated_at\": \"0000-00-00 00:00:00\"\n            }\n        },\n        {\n            \"id\": \"12\",\n            \"user_id\": \"1\",\n            \"partner_id\": \"3\",\n            \"type\": \"1\",\n            \"order_date\": \"2023-01-29 00:00:00\",\n            \"facility_booking_id\": \"24\",\n            \"session_id\": null,\n            \"tournament_id\": null,\n            \"amount\": \"50\",\n            \"transaction_id\": \"9\",\n            \"experience_id\": null,\n            \"status\": \"1\",\n            \"created_at\": \"2023-01-29 02:13:44\",\n            \"updated_at\": \"0000-00-00 00:00:00\",\n            \"facility\": {\n                \"id\": \"1\",\n                \"title\": \"Cricket\",\n                \"venue_id\": \"1\",\n                \"no_of_inventories\": \"3\",\n                \"min_players\": \"5\",\n                \"max_players\": \"11\",\n                \"default_players\": \"5\",\n                \"price_per_slot\": \"15\",\n                \"opening_time\": \"17:00:00\",\n                \"closing_time\": \"23:59:59\",\n                \"available_24_hours\": \"1\",\n                \"slot_length_hrs\": \"1\",\n                \"slot_length_min\": \"30\",\n                \"slot_frequency\": \"1\",\n                \"activity\": \"false\",\n                \"status\": \"1\",\n                \"created_at\": \"2023-01-28 17:31:33\",\n                \"updated_at\": \"2023-01-29 10:01:33\"\n            },\n            \"tournament\": {\n                \"id\": \"1\",\n                \"user_id\": \"7\",\n                \"academy_id\": \"2\",\n                \"title\": \"Academy Tournaments\",\n                \"no_of_tickets\": \"100\",\n                \"tickets_left\": null,\n                \"price\": \"100\",\n                \"start_date\": \"0000-00-00 00:00:00\",\n                \"end_date\": \"0000-00-00 00:00:00\",\n                \"description\": \"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s\",\n                \"type\": \"2\",\n                \"image\": \"2747image_picker_B41E2C1A-BE90-4665-9442-EED986DC105A-11713-000001D530326DDC.jpg\",\n                \"url\": \"-\",\n                \"approved\": \"0\",\n                \"status\": \"1\",\n                \"created_at\": \"0000-00-00 00:00:00\",\n                \"updated_at\": \"0000-00-00 00:00:00\"\n            },\n            \"experience\": null,\n            \"user\": {\n                \"id\": \"1\",\n                \"name\": \"Qwerty\",\n                \"email\": \"qwertty@gmail.com\",\n                \"password\": \"e6e061838856bf47e1de730719fb2609\",\n                \"phone\": \"9876543210\",\n                \"type\": \"1\",\n                \"image\": null,\n                \"status\": \"1\",\n                \"encrypt_password\": null,\n                \"created_at\": \"2022-12-21 23:58:12\",\n                \"updated_at\": \"0000-00-00 00:00:00\"\n            }\n        },\n        {\n            \"id\": \"13\",\n            \"user_id\": \"1\",\n            \"partner_id\": \"3\",\n            \"type\": \"1\",\n            \"order_date\": \"2023-01-29 00:00:00\",\n            \"facility_booking_id\": \"24\",\n            \"session_id\": null,\n            \"tournament_id\": null,\n            \"amount\": \"50\",\n            \"transaction_id\": \"10\",\n            \"experience_id\": null,\n            \"status\": \"1\",\n            \"created_at\": \"2023-01-29 02:14:38\",\n            \"updated_at\": \"0000-00-00 00:00:00\",\n            \"facility\": {\n                \"id\": \"1\",\n                \"title\": \"Cricket\",\n                \"venue_id\": \"1\",\n                \"no_of_inventories\": \"3\",\n                \"min_players\": \"5\",\n                \"max_players\": \"11\",\n                \"default_players\": \"5\",\n                \"price_per_slot\": \"15\",\n                \"opening_time\": \"17:00:00\",\n                \"closing_time\": \"23:59:59\",\n                \"available_24_hours\": \"1\",\n                \"slot_length_hrs\": \"1\",\n                \"slot_length_min\": \"30\",\n                \"slot_frequency\": \"1\",\n                \"activity\": \"false\",\n                \"status\": \"1\",\n                \"created_at\": \"2023-01-28 17:31:33\",\n                \"updated_at\": \"2023-01-29 10:01:33\"\n            },\n            \"tournament\": {\n                \"id\": \"1\",\n                \"user_id\": \"7\",\n                \"academy_id\": \"2\",\n                \"title\": \"Academy Tournaments\",\n                \"no_of_tickets\": \"100\",\n                \"tickets_left\": null,\n                \"price\": \"100\",\n                \"start_date\": \"0000-00-00 00:00:00\",\n                \"end_date\": \"0000-00-00 00:00:00\",\n                \"description\": \"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s\",\n                \"type\": \"2\",\n                \"image\": \"2747image_picker_B41E2C1A-BE90-4665-9442-EED986DC105A-11713-000001D530326DDC.jpg\",\n                \"url\": \"-\",\n                \"approved\": \"0\",\n                \"status\": \"1\",\n                \"created_at\": \"0000-00-00 00:00:00\",\n                \"updated_at\": \"0000-00-00 00:00:00\"\n            },\n            \"experience\": null,\n            \"user\": {\n                \"id\": \"1\",\n                \"name\": \"Qwerty\",\n                \"email\": \"qwertty@gmail.com\",\n                \"password\": \"e6e061838856bf47e1de730719fb2609\",\n                \"phone\": \"9876543210\",\n                \"type\": \"1\",\n                \"image\": null,\n                \"status\": \"1\",\n                \"encrypt_password\": null,\n                \"created_at\": \"2022-12-21 23:58:12\",\n                \"updated_at\": \"0000-00-00 00:00:00\"\n            }\n        },\n        {\n            \"id\": \"14\",\n            \"user_id\": \"1\",\n            \"partner_id\": \"3\",\n            \"type\": \"1\",\n            \"order_date\": \"2023-01-29 00:00:00\",\n            \"facility_booking_id\": \"29\",\n            \"session_id\": null,\n            \"tournament_id\": null,\n            \"amount\": \"50\",\n            \"transaction_id\": \"11\",\n            \"experience_id\": null,\n            \"status\": \"1\",\n            \"created_at\": \"2023-01-29 02:14:59\",\n            \"updated_at\": \"0000-00-00 00:00:00\",\n            \"facility\": {\n                \"id\": \"1\",\n                \"title\": \"Cricket\",\n                \"venue_id\": \"1\",\n                \"no_of_inventories\": \"3\",\n                \"min_players\": \"5\",\n                \"max_players\": \"11\",\n                \"default_players\": \"5\",\n                \"price_per_slot\": \"15\",\n                \"opening_time\": \"17:00:00\",\n                \"closing_time\": \"23:59:59\",\n                \"available_24_hours\": \"1\",\n                \"slot_length_hrs\": \"1\",\n                \"slot_length_min\": \"30\",\n                \"slot_frequency\": \"1\",\n                \"activity\": \"false\",\n                \"status\": \"1\",\n                \"created_at\": \"2023-01-28 17:31:33\",\n                \"updated_at\": \"2023-01-29 10:01:33\"\n            },\n            \"tournament\": {\n                \"id\": \"1\",\n                \"user_id\": \"7\",\n                \"academy_id\": \"2\",\n                \"title\": \"Academy Tournaments\",\n                \"no_of_tickets\": \"100\",\n                \"tickets_left\": null,\n                \"price\": \"100\",\n                \"start_date\": \"0000-00-00 00:00:00\",\n                \"end_date\": \"0000-00-00 00:00:00\",\n                \"description\": \"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s\",\n                \"type\": \"2\",\n                \"image\": \"2747image_picker_B41E2C1A-BE90-4665-9442-EED986DC105A-11713-000001D530326DDC.jpg\",\n                \"url\": \"-\",\n                \"approved\": \"0\",\n                \"status\": \"1\",\n                \"created_at\": \"0000-00-00 00:00:00\",\n                \"updated_at\": \"0000-00-00 00:00:00\"\n            },\n            \"experience\": null,\n            \"user\": {\n                \"id\": \"1\",\n                \"name\": \"Qwerty\",\n                \"email\": \"qwertty@gmail.com\",\n                \"password\": \"e6e061838856bf47e1de730719fb2609\",\n                \"phone\": \"9876543210\",\n                \"type\": \"1\",\n                \"image\": null,\n                \"status\": \"1\",\n                \"encrypt_password\": null,\n                \"created_at\": \"2022-12-21 23:58:12\",\n                \"updated_at\": \"0000-00-00 00:00:00\"\n            }\n        },\n        {\n            \"id\": \"15\",\n            \"user_id\": \"1\",\n            \"partner_id\": \"3\",\n            \"type\": \"1\",\n            \"order_date\": \"2023-01-29 00:00:00\",\n            \"facility_booking_id\": \"29\",\n            \"session_id\": null,\n            \"tournament_id\": null,\n            \"amount\": \"50\",\n            \"transaction_id\": null,\n            \"experience_id\": null,\n            \"status\": \"2\",\n            \"created_at\": \"2023-01-29 18:45:07\",\n            \"updated_at\": \"0000-00-00 00:00:00\",\n            \"facility\": {\n                \"id\": \"1\",\n                \"title\": \"Cricket\",\n                \"venue_id\": \"1\",\n                \"no_of_inventories\": \"3\",\n                \"min_players\": \"5\",\n                \"max_players\": \"11\",\n                \"default_players\": \"5\",\n                \"price_per_slot\": \"15\",\n                \"opening_time\": \"17:00:00\",\n                \"closing_time\": \"23:59:59\",\n                \"available_24_hours\": \"1\",\n                \"slot_length_hrs\": \"1\",\n                \"slot_length_min\": \"30\",\n                \"slot_frequency\": \"1\",\n                \"activity\": \"false\",\n                \"status\": \"1\",\n                \"created_at\": \"2023-01-28 17:31:33\",\n                \"updated_at\": \"2023-01-29 10:01:33\"\n            },\n            \"tournament\": {\n                \"id\": \"1\",\n                \"user_id\": \"7\",\n                \"academy_id\": \"2\",\n                \"title\": \"Academy Tournaments\",\n                \"no_of_tickets\": \"100\",\n                \"tickets_left\": null,\n                \"price\": \"100\",\n                \"start_date\": \"0000-00-00 00:00:00\",\n                \"end_date\": \"0000-00-00 00:00:00\",\n                \"description\": \"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s\",\n                \"type\": \"2\",\n                \"image\": \"2747image_picker_B41E2C1A-BE90-4665-9442-EED986DC105A-11713-000001D530326DDC.jpg\",\n                \"url\": \"-\",\n                \"approved\": \"0\",\n                \"status\": \"1\",\n                \"created_at\": \"0000-00-00 00:00:00\",\n                \"updated_at\": \"0000-00-00 00:00:00\"\n            },\n            \"experience\": null,\n            \"user\": {\n                \"id\": \"1\",\n                \"name\": \"Qwerty\",\n                \"email\": \"qwertty@gmail.com\",\n                \"password\": \"e6e061838856bf47e1de730719fb2609\",\n                \"phone\": \"9876543210\",\n                \"type\": \"1\",\n                \"image\": null,\n                \"status\": \"1\",\n                \"encrypt_password\": null,\n                \"created_at\": \"2022-12-21 23:58:12\",\n                \"updated_at\": \"0000-00-00 00:00:00\"\n            }\n        },\n        {\n            \"id\": \"16\",\n            \"user_id\": \"1\",\n            \"partner_id\": \"3\",\n            \"type\": \"1\",\n            \"order_date\": \"2023-01-29 00:00:00\",\n            \"facility_booking_id\": \"31\",\n            \"session_id\": null,\n            \"tournament_id\": null,\n            \"amount\": \"15\",\n            \"transaction_id\": \"12\",\n            \"experience_id\": null,\n            \"status\": \"1\",\n            \"created_at\": \"2023-01-29 02:16:52\",\n            \"updated_at\": \"0000-00-00 00:00:00\",\n            \"facility\": {\n                \"id\": \"1\",\n                \"title\": \"Cricket\",\n                \"venue_id\": \"1\",\n                \"no_of_inventories\": \"3\",\n                \"min_players\": \"5\",\n                \"max_players\": \"11\",\n                \"default_players\": \"5\",\n                \"price_per_slot\": \"15\",\n                \"opening_time\": \"17:00:00\",\n                \"closing_time\": \"23:59:59\",\n                \"available_24_hours\": \"1\",\n                \"slot_length_hrs\": \"1\",\n                \"slot_length_min\": \"30\",\n                \"slot_frequency\": \"1\",\n                \"activity\": \"false\",\n                \"status\": \"1\",\n                \"created_at\": \"2023-01-28 17:31:33\",\n                \"updated_at\": \"2023-01-29 10:01:33\"\n            },\n            \"tournament\": {\n                \"id\": \"1\",\n                \"user_id\": \"7\",\n                \"academy_id\": \"2\",\n                \"title\": \"Academy Tournaments\",\n                \"no_of_tickets\": \"100\",\n                \"tickets_left\": null,\n                \"price\": \"100\",\n                \"start_date\": \"0000-00-00 00:00:00\",\n                \"end_date\": \"0000-00-00 00:00:00\",\n                \"description\": \"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s\",\n                \"type\": \"2\",\n                \"image\": \"2747image_picker_B41E2C1A-BE90-4665-9442-EED986DC105A-11713-000001D530326DDC.jpg\",\n                \"url\": \"-\",\n                \"approved\": \"0\",\n                \"status\": \"1\",\n                \"created_at\": \"0000-00-00 00:00:00\",\n                \"updated_at\": \"0000-00-00 00:00:00\"\n            },\n            \"experience\": null,\n            \"user\": {\n                \"id\": \"1\",\n                \"name\": \"Qwerty\",\n                \"email\": \"qwertty@gmail.com\",\n                \"password\": \"e6e061838856bf47e1de730719fb2609\",\n                \"phone\": \"9876543210\",\n                \"type\": \"1\",\n                \"image\": null,\n                \"status\": \"1\",\n                \"encrypt_password\": null,\n                \"created_at\": \"2022-12-21 23:58:12\",\n                \"updated_at\": \"0000-00-00 00:00:00\"\n            }\n        },\n        {\n            \"id\": \"17\",\n            \"user_id\": \"1\",\n            \"partner_id\": \"3\",\n            \"type\": \"1\",\n            \"order_date\": \"2023-01-29 00:00:00\",\n            \"facility_booking_id\": \"32\",\n            \"session_id\": null,\n            \"tournament_id\": null,\n            \"amount\": \"15\",\n            \"transaction_id\": \"13\",\n            \"experience_id\": null,\n            \"status\": \"1\",\n            \"created_at\": \"2023-01-29 02:17:59\",\n            \"updated_at\": \"0000-00-00 00:00:00\",\n            \"facility\": {\n                \"id\": \"1\",\n                \"title\": \"Cricket\",\n                \"venue_id\": \"1\",\n                \"no_of_inventories\": \"3\",\n                \"min_players\": \"5\",\n                \"max_players\": \"11\",\n                \"default_players\": \"5\",\n                \"price_per_slot\": \"15\",\n                \"opening_time\": \"17:00:00\",\n                \"closing_time\": \"23:59:59\",\n                \"available_24_hours\": \"1\",\n                \"slot_length_hrs\": \"1\",\n                \"slot_length_min\": \"30\",\n                \"slot_frequency\": \"1\",\n                \"activity\": \"false\",\n                \"status\": \"1\",\n                \"created_at\": \"2023-01-28 17:31:33\",\n                \"updated_at\": \"2023-01-29 10:01:33\"\n            },\n            \"tournament\": {\n                \"id\": \"1\",\n                \"user_id\": \"7\",\n                \"academy_id\": \"2\",\n                \"title\": \"Academy Tournaments\",\n                \"no_of_tickets\": \"100\",\n                \"tickets_left\": null,\n                \"price\": \"100\",\n                \"start_date\": \"0000-00-00 00:00:00\",\n                \"end_date\": \"0000-00-00 00:00:00\",\n                \"description\": \"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s\",\n                \"type\": \"2\",\n                \"image\": \"2747image_picker_B41E2C1A-BE90-4665-9442-EED986DC105A-11713-000001D530326DDC.jpg\",\n                \"url\": \"-\",\n                \"approved\": \"0\",\n                \"status\": \"1\",\n                \"created_at\": \"0000-00-00 00:00:00\",\n                \"updated_at\": \"0000-00-00 00:00:00\"\n            },\n            \"experience\": null,\n            \"user\": {\n                \"id\": \"1\",\n                \"name\": \"Qwerty\",\n                \"email\": \"qwertty@gmail.com\",\n                \"password\": \"e6e061838856bf47e1de730719fb2609\",\n                \"phone\": \"9876543210\",\n                \"type\": \"1\",\n                \"image\": null,\n                \"status\": \"1\",\n                \"encrypt_password\": null,\n                \"created_at\": \"2022-12-21 23:58:12\",\n                \"updated_at\": \"0000-00-00 00:00:00\"\n            }\n        },\n        {\n            \"id\": \"18\",\n            \"user_id\": \"1\",\n            \"partner_id\": \"3\",\n            \"type\": \"1\",\n            \"order_date\": \"2023-01-29 00:00:00\",\n            \"facility_booking_id\": \"33\",\n            \"session_id\": null,\n            \"tournament_id\": null,\n            \"amount\": \"15\",\n            \"transaction_id\": \"14\",\n            \"experience_id\": null,\n            \"status\": \"1\",\n            \"created_at\": \"2023-01-29 02:20:23\",\n            \"updated_at\": \"0000-00-00 00:00:00\",\n            \"facility\": {\n                \"id\": \"2\",\n                \"title\": \"Footbal\",\n                \"venue_id\": \"1\",\n                \"no_of_inventories\": \"3\",\n                \"min_players\": \"5\",\n                \"max_players\": \"11\",\n                \"default_players\": \"1\",\n                \"price_per_slot\": \"15\",\n                \"opening_time\": \"09:00:00\",\n                \"closing_time\": \"08:00:00\",\n                \"available_24_hours\": \"1\",\n                \"slot_length_hrs\": \"10\",\n                \"slot_length_min\": \"30\",\n                \"slot_frequency\": \"124\",\n                \"activity\": \"false\",\n                \"status\": \"1\",\n                \"created_at\": \"2023-01-25 12:23:12\",\n                \"updated_at\": \"2023-01-25 18:02:11\"\n            },\n            \"tournament\": {\n                \"id\": \"1\",\n                \"user_id\": \"7\",\n                \"academy_id\": \"2\",\n                \"title\": \"Academy Tournaments\",\n                \"no_of_tickets\": \"100\",\n                \"tickets_left\": null,\n                \"price\": \"100\",\n                \"start_date\": \"0000-00-00 00:00:00\",\n                \"end_date\": \"0000-00-00 00:00:00\",\n                \"description\": \"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s\",\n                \"type\": \"2\",\n                \"image\": \"2747image_picker_B41E2C1A-BE90-4665-9442-EED986DC105A-11713-000001D530326DDC.jpg\",\n                \"url\": \"-\",\n                \"approved\": \"0\",\n                \"status\": \"1\",\n                \"created_at\": \"0000-00-00 00:00:00\",\n                \"updated_at\": \"0000-00-00 00:00:00\"\n            },\n            \"experience\": null,\n            \"user\": {\n                \"id\": \"1\",\n                \"name\": \"Qwerty\",\n                \"email\": \"qwertty@gmail.com\",\n                \"password\": \"e6e061838856bf47e1de730719fb2609\",\n                \"phone\": \"9876543210\",\n                \"type\": \"1\",\n                \"image\": null,\n                \"status\": \"1\",\n                \"encrypt_password\": null,\n                \"created_at\": \"2022-12-21 23:58:12\",\n                \"updated_at\": \"0000-00-00 00:00:00\"\n            }\n        },\n        {\n            \"id\": \"19\",\n            \"user_id\": \"1\",\n            \"partner_id\": \"3\",\n            \"type\": \"3\",\n            \"order_date\": \"2023-01-29 00:00:00\",\n            \"facility_booking_id\": null,\n            \"session_id\": null,\n            \"tournament_id\": \"4\",\n            \"amount\": \"120\",\n            \"transaction_id\": \"15\",\n            \"experience_id\": null,\n            \"status\": \"1\",\n            \"created_at\": \"2023-01-29 02:58:36\",\n            \"updated_at\": \"0000-00-00 00:00:00\",\n            \"tournament\": {\n                \"id\": \"4\",\n                \"user_id\": \"30\",\n                \"academy_id\": \"4\",\n                \"title\": \"Cricket Tounament\",\n                \"no_of_tickets\": \"50\",\n                \"tickets_left\": null,\n                \"price\": \"120\",\n                \"start_date\": null,\n                \"end_date\": null,\n                \"description\": \"Come play and win\",\n                \"type\": \"1\",\n                \"image\": \"\",\n                \"url\": null,\n                \"approved\": \"0\",\n                \"status\": \"1\",\n                \"created_at\": \"0000-00-00 00:00:00\",\n                \"updated_at\": \"0000-00-00 00:00:00\"\n            },\n            \"experience\": null,\n            \"user\": {\n                \"id\": \"1\",\n                \"name\": \"Qwerty\",\n                \"email\": \"qwertty@gmail.com\",\n                \"password\": \"e6e061838856bf47e1de730719fb2609\",\n                \"phone\": \"9876543210\",\n                \"type\": \"1\",\n                \"image\": null,\n                \"status\": \"1\",\n                \"encrypt_password\": null,\n                \"created_at\": \"2022-12-21 23:58:12\",\n                \"updated_at\": \"0000-00-00 00:00:00\"\n            }\n        },\n        {\n            \"id\": \"20\",\n            \"user_id\": \"1\",\n            \"partner_id\": \"3\",\n            \"type\": \"4\",\n            \"order_date\": \"2023-01-29 00:00:00\",\n            \"facility_booking_id\": null,\n            \"session_id\": null,\n            \"tournament_id\": null,\n            \"amount\": \"12\",\n            \"transaction_id\": \"16\",\n            \"experience_id\": \"1\",\n            \"status\": \"1\",\n            \"created_at\": \"2023-01-30 01:40:53\",\n            \"updated_at\": \"0000-00-00 00:00:00\",\n            \"tournament\": {\n                \"id\": \"4\",\n                \"user_id\": \"30\",\n                \"academy_id\": \"4\",\n                \"title\": \"Cricket Tounament\",\n                \"no_of_tickets\": \"50\",\n                \"tickets_left\": null,\n                \"price\": \"120\",\n                \"start_date\": null,\n                \"end_date\": null,\n                \"description\": \"Come play and win\",\n                \"type\": \"1\",\n                \"image\": \"\",\n                \"url\": null,\n                \"approved\": \"0\",\n                \"status\": \"1\",\n                \"created_at\": \"0000-00-00 00:00:00\",\n                \"updated_at\": \"0000-00-00 00:00:00\"\n            },\n            \"experience\": {\n                \"id\": \"1\",\n                \"title\": \"Racing\",\n                \"description\": \"description\",\n                \"price\": \"12\",\n                \"venue_id\": \"1\",\n                \"user_id\": \"7\",\n                \"address\": \"\",\n                \"start_time\": \"\",\n                \"image\": \"1711exp2.jpg\",\n                \"status\": \"1\",\n                \"created_at\": \"2023-01-24 20:50:52\",\n                \"updated_at\": \"2023-01-28 16:05:29\"\n            },\n            \"user\": {\n                \"id\": \"1\",\n                \"name\": \"Qwerty\",\n                \"email\": \"qwertty@gmail.com\",\n                \"password\": \"e6e061838856bf47e1de730719fb2609\",\n                \"phone\": \"9876543210\",\n                \"type\": \"1\",\n                \"image\": null,\n                \"status\": \"1\",\n                \"encrypt_password\": null,\n                \"created_at\": \"2022-12-21 23:58:12\",\n                \"updated_at\": \"0000-00-00 00:00:00\"\n            }\n        }\n    ]\n}"));

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
