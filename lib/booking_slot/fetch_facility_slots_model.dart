// To parse this JSON data, do
//
//     final fetchSlotsResponseModel = fetchSlotsResponseModelFromJson(jsonString);

import 'dart:convert';

FetchSlotsResponseModel fetchSlotsResponseModelFromJson(String str) =>
    FetchSlotsResponseModel.fromJson(json.decode(str));

String fetchSlotsResponseModelToJson(FetchSlotsResponseModel data) =>
    json.encode(data.toJson());

class FetchSlotsResponseModel {
  FetchSlotsResponseModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<Datum>? data;

  factory FetchSlotsResponseModel.fromJson(Map<String, dynamic> json) =>
      FetchSlotsResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : json["data"] is List
                ? List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x)))
                : [],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.facility_id,
    this.slotStartTime,
    this.slotEndTime,
    this.slotBlockStatus,
    this.slotBookingStatus,
    this.slotBookingDetail,
    this.user
  });

  String? slotStartTime;
  String? slotEndTime;
  String? facility_id;
  int? slotBlockStatus;
  int? slotBookingStatus;
  SlotBookingDetail? slotBookingDetail;
  User? user;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        facility_id: json['facility_id'],
        slotStartTime: json["slot_start_time"],
        slotEndTime: json["slot_end_time"],
        slotBlockStatus: json["slot_block_status"],
        slotBookingStatus: json["slot_booking_status"],
        slotBookingDetail:
            SlotBookingDetail.fromJson(json["slot_booking_detail"] ?? {}
            ),
        user: User.fromJson(json['user'] ?? {})
        
      );

  Map<String, dynamic> toJson() => {
        "facility_id": facility_id,
        "slot_start_time": slotStartTime,
        "slot_end_time": slotEndTime,
        "slot_block_status": slotBlockStatus,
        "slot_booking_status": slotBookingStatus,
        "slot_booking_detail": slotBookingDetail?.toJson(),
        "user": user?.toJson()
      };
}

class SlotBookingDetail {
  SlotBookingDetail({
    this.id,
    this.facilityId,
    this.userId,
    this.bookBy,
    this.date,
    this.slotStartTime,
    this.slotEndTime,
    this.transactionId,
    this.bookingStatus,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? facilityId;
  String? userId;
  String? bookBy;
  DateTime? date;
  String? slotStartTime;
  String? slotEndTime;
  String? transactionId;
  String? bookingStatus;
  String? status;
  String? createdAt;
  String? updatedAt;

  factory SlotBookingDetail.fromJson(Map<String, dynamic> json,) =>
      SlotBookingDetail(
        id: json["id"],
        facilityId: json["facility_id"],
        userId: json["user_id"],
        bookBy: json["book_by"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        slotStartTime: json["slot_start_time"],
        slotEndTime: json["slot_end_time"],
        transactionId: json["transaction_id"],
        bookingStatus: json["booking_status"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        // user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "facility_id": facilityId,
        "user_id": userId,
        "book_by": bookBy,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "slot_start_time": slotStartTime,
        "slot_end_time": slotEndTime,
        "transaction_id": transactionId,
        "booking_status": bookingStatus,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        // "user": user?.toJson(),
      };
}

class User {
  User({
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
  });

  String? id;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? type;
  dynamic image;
  String? status;
  dynamic encryptPassword;
  String? createdAt;
  String? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
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
      };
}
