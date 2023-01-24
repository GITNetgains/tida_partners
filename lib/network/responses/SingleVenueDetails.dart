class SingleVenueDetails {
  bool? status;
  String? message;
  List<Data>? data;

  SingleVenueDetails({this.status, this.message, this.data});

  SingleVenueDetails.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  String? image;
  String? title;
  String? sports;
  String? amenities;
  String? description;
  String? address;
  String? addressMap;
  String? latitude;
  String? longitude;
  String? status;
  String? createdAt;
  String? updatedAt;
  bool? facilities;
  List<Rating>? rating;
  bool? sportsDetails;
  bool? amenitiesDetails;

  Data(
      {this.id,
        this.userId,
        this.image,
        this.title,
        this.sports,
        this.amenities,
        this.description,
        this.address,
        this.addressMap,
        this.latitude,
        this.longitude,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.facilities,
        this.rating,
        this.sportsDetails,
        this.amenitiesDetails});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    image = json['image'];
    title = json['title'];
    sports = json['sports'];
    amenities = json['amenities'];
    description = json['description'];
    address = json['address'];
    addressMap = json['address_map'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    facilities = json['facilities'];
    if (json['rating'] != null) {
      rating = <Rating>[];
      json['rating'].forEach((v) {
        rating!.add(new Rating.fromJson(v));
      });
    }
    sportsDetails = json['sports_details'];
    amenitiesDetails = json['amenities_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['image'] = this.image;
    data['title'] = this.title;
    data['sports'] = this.sports;
    data['amenities'] = this.amenities;
    data['description'] = this.description;
    data['address'] = this.address;
    data['address_map'] = this.addressMap;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['facilities'] = this.facilities;
    if (this.rating != null) {
      data['rating'] = this.rating!.map((v) => v.toJson()).toList();
    }
    data['sports_details'] = this.sportsDetails;
    data['amenities_details'] = this.amenitiesDetails;
    return data;
  }
}

class Rating {
  String? id;
  String? userId;
  String? review;
  String? rating;
  String? postType;
  String? postId;
  String? status;
  String? createdAt;

  Rating(
      {this.id,
        this.userId,
        this.review,
        this.rating,
        this.postType,
        this.postId,
        this.status,
        this.createdAt});

  Rating.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    review = json['review'];
    rating = json['rating'];
    postType = json['post_type'];
    postId = json['post_id'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['review'] = this.review;
    data['rating'] = this.rating;
    data['post_type'] = this.postType;
    data['post_id'] = this.postId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}
