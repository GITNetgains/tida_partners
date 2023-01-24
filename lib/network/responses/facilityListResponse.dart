class FacilityListResponse {
  bool? status;
  String? message;
  List<Data>? data;

  FacilityListResponse({this.status, this.message, this.data});

  FacilityListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? title;
  String? venueId;
  String? noOfInventories;
  String? minPlayers;
  String? maxPlayers;
  String? defaultPlayers;
  String? pricePerSlot;
  String? openingTime;
  String? closingTime;
  String? available24Hours;
  String? slotLengthHrs;
  String? slotLengthMin;
  String? slotFrequency;
  String? activity;
  String? status;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.title,
        this.venueId,
        this.noOfInventories,
        this.minPlayers,
        this.maxPlayers,
        this.defaultPlayers,
        this.pricePerSlot,
        this.openingTime,
        this.closingTime,
        this.available24Hours,
        this.slotLengthHrs,
        this.slotLengthMin,
        this.slotFrequency,
        this.activity,
        this.status,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    venueId = json['venue_id'];
    noOfInventories = json['no_of_inventories'];
    minPlayers = json['min_players'];
    maxPlayers = json['max_players'];
    defaultPlayers = json['default_players'];
    pricePerSlot = json['price_per_slot'];
    openingTime = json['opening_time'];
    closingTime = json['closing_time'];
    available24Hours = json['available_24_hours'];
    slotLengthHrs = json['slot_length_hrs'];
    slotLengthMin = json['slot_length_min'];
    slotFrequency = json['slot_frequency'];
    activity = json['activity'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['venue_id'] = this.venueId;
    data['no_of_inventories'] = this.noOfInventories;
    data['min_players'] = this.minPlayers;
    data['max_players'] = this.maxPlayers;
    data['default_players'] = this.defaultPlayers;
    data['price_per_slot'] = this.pricePerSlot;
    data['opening_time'] = this.openingTime;
    data['closing_time'] = this.closingTime;
    data['available_24_hours'] = this.available24Hours;
    data['slot_length_hrs'] = this.slotLengthHrs;
    data['slot_length_min'] = this.slotLengthMin;
    data['slot_frequency'] = this.slotFrequency;
    data['activity'] = this.activity;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
