class VenueList {
  bool? status;
  String? message;
  List<Data>? data;

  VenueList({this.status, this.message, this.data});

  VenueList.fromJson(Map<String, dynamic> json) {
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
  String? image;
  String? title;
  String? sports;
  String? amenities;
  String? description;
  String? address;
  String? addressMap;
  String? status;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.image,
        this.title,
        this.sports,
        this.amenities,
        this.description,
        this.address,
        this.addressMap,
        this.status,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
    sports = json['sports'];
    amenities = json['amenities'];
    description = json['description'];
    address = json['address'];
    addressMap = json['address_map'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['title'] = this.title;
    data['sports'] = this.sports;
    data['amenities'] = this.amenities;
    data['description'] = this.description;
    data['address'] = this.address;
    data['address_map'] = this.addressMap;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
