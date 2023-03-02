class ExperienceListResponse {
  bool? status;
  String? message;
  List<Data>? data;

  ExperienceListResponse({this.status, this.message, this.data});

  ExperienceListResponse.fromJson(Map<String, dynamic> json) {
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
  String? description;
  String? price;
  String? venueId;
  String? userId;
  String? address;
  String? startTime;
  String? image;
  String? status;
  String? createdAt;
  String? venuName;
  String? updatedAt;
  String? longitude;
  String? latitude;
  bool? rating;

  Data(
      {this.id,
        this.title,
        this.description,
        this.price,
        this.venueId,
        this.userId,
        this.address,
        this.startTime,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.venuName,
        this.longitude,
        this.latitude,
        this.rating});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    venueId = json['venue_id'];
    userId = json['user_id'];
    address = json['address'];
    startTime = json['start_time'];
    image = json['image'];
    status = json['status'];
    venuName = json['venue_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    latitude = json['latitude'];
    longitude = json['longitude'];

    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['price'] = this.price;
    data['venue_id'] = this.venueId;
    data['user_id'] = this.userId;
    data['address'] = this.address;
    data['start_time'] = this.startTime;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['venue_name'] = this.venuName;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['rating'] = this.rating;
    return data;
  }
}
