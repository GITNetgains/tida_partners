import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tida_partners/AppUtils.dart';
import 'package:tida_partners/network/responses/LoginResponse.dart';
import 'package:tida_partners/network/responses/TournamentListResponse.dart';
import 'package:tida_partners/network/responses/amenities_res.dart';
import 'package:tida_partners/network/responses/media_response.dart';
import 'package:tida_partners/utilss/SharedPref.dart';

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
    data['token'] = token;
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

  Future<bool> addAcademy(Map<String, String> data, String path) async {
    String token = Preferences.getToken();
    String user_id = Preferences.getUserId();
    data['userid'] = user_id;
    data['token'] = token;

    var request = http.MultipartRequest('POST', Uri.parse(ADD_ACADEMY));
    request.headers.addAll({
      'Accept': 'application/json',
    });

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
    final responseData = json.decode(responsed.body);
    print(jsonEncode(responsed.body));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateAcademy(Map<String, String> data, String path) async {
    String token = Preferences.getToken();
    String user_id = Preferences.getUserId();
    data['userid'] = user_id;
    data['token'] = token;

    var request = http.MultipartRequest('POST', Uri.parse(UPDATE_ACADEMY));
    request.headers.addAll({
      'Accept': 'application/json',
    });

    //for image and videos and files
    request.fields.assignAll(data);

    try{
      if (path.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath("logo", path));
      } else {
        // data['logo'] = "null";
      }

    }catch(e){


    }


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
        AppUtills.showSnackBar("Error",
            datares.message ?? "Something Went Wrong. Please try again.",
            isError: true);
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

    http.Response res = await http.post(Uri.parse(GET_EXPERIENCE),
        headers: headers, body: data);
    print(jsonEncode(res.body));
    if (res.statusCode == 200) {
      ExperienceListResponse datares =
      ExperienceListResponse.fromJson(jsonDecode(res.body));
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

  Future<FacilityListResponse?> fetchFacilities() async {
    String token = Preferences.getToken();
    String user_id = Preferences.getUserId();
    Map<String, String> data = {};
    data['userid'] = user_id;
    data['token'] = token;

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
}
