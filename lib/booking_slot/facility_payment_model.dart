// To parse this JSON data, do
//
//     final facilityPaymentResModel = facilityPaymentResModelFromJson(jsonString);

import 'dart:convert';

FacilityPaymentResModel facilityPaymentResModelFromJson(String str) => FacilityPaymentResModel.fromJson(json.decode(str));

String facilityPaymentResModelToJson(FacilityPaymentResModel data) => json.encode(data.toJson());

class FacilityPaymentResModel {
    FacilityPaymentResModel({
        this.status,
        this.message,
    });

    bool? status;
    String? message;

    factory FacilityPaymentResModel.fromJson(Map<String, dynamic> json) => FacilityPaymentResModel(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
