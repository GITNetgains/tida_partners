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
  String? videoUrl;
  String? status;
  String? createdAt;
  String? updatedAt;
  List<Facilities>? facilities;
  List<Rating>? rating;
  List<SportsDetails>? sportsDetails;
  List<AmenitiesDetails>? amenitiesDetails;

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
        this.videoUrl,
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
    videoUrl = json['video_url'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['facilities'] != null) {
      facilities = <Facilities>[];
      try{
        json['facilities'].forEach((v) {
          facilities!.add(new Facilities.fromJson(v));
        });

      }catch(e){
        facilities = null;

      }

    }
    if (json['rating'] != null) {
      rating = <Rating>[];
      try{
        json['rating'].forEach((v) {
          rating!.add(new Rating.fromJson(v));
        });
      }catch(e){}
    }
    if (json['sports_details'] != null) {
      sportsDetails = <SportsDetails>[];
      json['sports_details'].forEach((v) {
        sportsDetails!.add(new SportsDetails.fromJson(v));
      });
    }
    if (json['amenities_details'] != null) {
      amenitiesDetails = <AmenitiesDetails>[];
      json['amenities_details'].forEach((v) {
        amenitiesDetails!.add(new AmenitiesDetails.fromJson(v));
      });
    }
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
    data['video_url'] = this.videoUrl;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.facilities != null) {
      data['facilities'] = this.facilities!.map((v) => v.toJson()).toList();
    }
    if (this.rating != null) {
      data['rating'] = this.rating!.map((v) => v.toJson()).toList();
    }
    if (this.sportsDetails != null) {
      data['sports_details'] =
          this.sportsDetails!.map((v) => v.toJson()).toList();
    }
    if (this.amenitiesDetails != null) {
      data['amenities_details'] =
          this.amenitiesDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Facilities {
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

  Facilities(
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

  Facilities.fromJson(Map<String, dynamic> json) {
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

class SportsDetails {
  String? id;
  String? sportName;
  String? sportPrice;
  String? sportIcon;
  String? status;
  String? createdAt;
  String? updatedAt;

  SportsDetails(
      {this.id,
        this.sportName,
        this.sportPrice,
        this.sportIcon,
        this.status,
        this.createdAt,
        this.updatedAt});

  SportsDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sportName = json['sport_name'];
    sportPrice = json['sport_price'];
    sportIcon = json['sport_icon'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sport_name'] = this.sportName;
    data['sport_price'] = this.sportPrice;
    data['sport_icon'] = this.sportIcon;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class AmenitiesDetails {
  String? id;
  String? name;
  String? icon;
  String? status;
  String? createdAt;
  String? updatedAt;

  AmenitiesDetails(
      {this.id,
        this.name,
        this.icon,
        this.status,
        this.createdAt,
        this.updatedAt});

  AmenitiesDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
