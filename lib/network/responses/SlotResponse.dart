class FacilitySlotResponse {
  bool? status;
  String? message;
  List<Data>? data;

  FacilitySlotResponse({this.status, this.message, this.data});

  FacilitySlotResponse.fromJson(Map<String, dynamic> json) {
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
  String? slotStartTime;
  String? slotEndTime;
  int? slotBlockStatus;
  int? slotBookingStatus;
  SlotBookingDetail? slotBookingDetail;

  Data(
      {this.slotStartTime,
        this.slotEndTime,
        this.slotBlockStatus,
        this.slotBookingStatus,
        this.slotBookingDetail});

  Data.fromJson(Map<String, dynamic> json) {
    slotStartTime = json['slot_start_time'];
    slotEndTime = json['slot_end_time'];
    slotBlockStatus = json['slot_block_status'];
    slotBookingStatus = json['slot_booking_status'];
    slotBookingDetail = json['slot_booking_detail'] != null
        ? new SlotBookingDetail.fromJson(json['slot_booking_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slot_start_time'] = this.slotStartTime;
    data['slot_end_time'] = this.slotEndTime;
    data['slot_block_status'] = this.slotBlockStatus;
    data['slot_booking_status'] = this.slotBookingStatus;
    if (this.slotBookingDetail != null) {
      data['slot_booking_detail'] = this.slotBookingDetail!.toJson();
    }
    return data;
  }
}

class SlotBookingDetail {
  String? id;
  String? facilityId;
  String? userId;
  String? bookBy;
  String? date;
  String? slotStartTime;
  String? slotEndTime;
  String? transactionId;
  String? bookingStatus;
  String? status;
  String? createdAt;
  String? updatedAt;
  User? user;

  SlotBookingDetail(
      {this.id,
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
        this.user});

  SlotBookingDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    facilityId = json['facility_id'];
    userId = json['user_id'];
    bookBy = json['book_by'];
    date = json['date'];
    slotStartTime = json['slot_start_time'];
    slotEndTime = json['slot_end_time'];
    transactionId = json['transaction_id'];
    bookingStatus = json['booking_status'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['facility_id'] = this.facilityId;
    data['user_id'] = this.userId;
    data['book_by'] = this.bookBy;
    data['date'] = this.date;
    data['slot_start_time'] = this.slotStartTime;
    data['slot_end_time'] = this.slotEndTime;
    data['transaction_id'] = this.transactionId;
    data['booking_status'] = this.bookingStatus;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? type;
  Null? image;
  String? status;
  Null? encryptPassword;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
        this.name,
        this.email,
        this.password,
        this.phone,
        this.type,
        this.image,
        this.status,
        this.encryptPassword,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    type = json['type'];
    image = json['image'];
    status = json['status'];
    encryptPassword = json['encrypt_password'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['type'] = this.type;
    data['image'] = this.image;
    data['status'] = this.status;
    data['encrypt_password'] = this.encryptPassword;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
