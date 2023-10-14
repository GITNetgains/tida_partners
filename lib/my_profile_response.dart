// To parse this JSON data, do
//
//     final profileResponse = profileResponseFromJson(jsonString);

import 'dart:convert';

ProfileResponse? profileResponseFromJson(String str) =>
    ProfileResponse.fromJson(json.decode(str));

String profileResponseToJson(ProfileResponse? data) =>
    json.encode(data!.toJson());

class ProfileResponse {
  ProfileResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Userdata? data;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      ProfileResponse(
        status: json["status"],
        message: json["message"],
        data: Userdata.fromJson(json["data"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data,
      };
}

class Userdata {
  Userdata({
    this.id,
    this.name,
    this.email,
    this.password,
    this.phone,
    this.type,
    this.image,
    this.status,
    this.encryptPassword,
    this.createdAt,
    this.updatedAt,
    this.token,
  });

  String? id;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? type;
  dynamic image;
  String? status;
  String? encryptPassword;
  String? createdAt;
  String? updatedAt;
  String? token;

  factory Userdata.fromJson(Map<String, dynamic> json) => Userdata(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
        type: json["type"],
        image: json["image"],
        status: json["status"],
        encryptPassword: json["encrypt_password"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
        "type": type,
        "image": image,
        "status": status,
        "encrypt_password": encryptPassword,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "token": token,
      };
}
