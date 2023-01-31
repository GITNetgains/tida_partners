// To parse this JSON data, do
//
//     final slotBookingResponseModel = slotBookingResponseModelFromJson(jsonString);

import 'dart:convert';

SlotBookingResponseModel slotBookingResponseModelFromJson(String str) => SlotBookingResponseModel.fromJson(json.decode(str));

String slotBookingResponseModelToJson(SlotBookingResponseModel data) => json.encode(data.toJson());

class SlotBookingResponseModel {
    SlotBookingResponseModel({
        this.status,
        this.message,
        this.data,
    });

    bool? status;
    String? message;
    List<Datum>? data;

    factory SlotBookingResponseModel.fromJson(Map<String, dynamic> json) => SlotBookingResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
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
    dynamic transactionId;
    String? bookingStatus;
    String? status;
    String? createdAt;
    String? updatedAt;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "facility_id": facilityId,
        "user_id": userId,
        "book_by": bookBy,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "slot_start_time": slotStartTime,
        "slot_end_time": slotEndTime,
        "transaction_id": transactionId,
        "booking_status": bookingStatus,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
