// To parse this JSON data, do
//
//     final ChangePasswordModel = ChangePasswordModelFromJson(jsonString);

import 'dart:convert';

ChangePasswordModel? ChangePasswordModelFromJson(String str) => ChangePasswordModel.fromJson(json.decode(str));

String ChangePasswordModelToJson(ChangePasswordModel? data) => json.encode(data!.toJson());

class ChangePasswordModel {
    ChangePasswordModel({
        this.status,
        this.message,
        this.data,
    });

    bool? status;
    String? message;
    bool? data;

    factory ChangePasswordModel.fromJson(Map<String, dynamic> json) => ChangePasswordModel(
        status: json["status"],
        message: json["message"],
        data: json["data"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data,
    };
}

class Data {
    Data({
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
    dynamic phone;
    String? type;
    dynamic image;
    String? status;
    String? encryptPassword;
    String? createdAt;
    String? updatedAt;
    String? token;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
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
