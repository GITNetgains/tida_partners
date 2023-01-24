class SingleAcademy {
  bool? status;
  String? message;
  List<Data>? data;

  SingleAcademy({this.status, this.message, this.data});

  SingleAcademy.fromJson(Map<String, dynamic> json) {
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
  Null? userId;
  String? venueId;
  String? name;
  String? address;
  String? logo;
  Null? latitude;
  Null? longitude;
  String? description;
  String? contactNo;
  String? headCoach;
  String? sessionTimings;
  String? weekDays;
  String? price;
  String? remarksPrice;
  String? skillLevel;
  String? academyJersey;
  String? capacity;
  String? remarksCurrentCapacity;
  String? sessionPlan;
  String? remarksSessionPlan;
  String? ageGroupOfStudents;
  String? remarksStudents;
  String? equipment;
  String? remarksOnEquipment;
  String? floodLights;
  String? groundSize;
  String? person;
  String? coachExperience;
  String? noOfAssistentCoach;
  String? assistentCoachName;
  String? feedbacks;
  Null? amenitiesId;
  String? status;
  String? createdAt;
  String? updatedAt;
  Null? amenitiesDetails;
  List<VenueDetails>? venueDetails;

  Data(
      {this.id,
        this.userId,
        this.venueId,
        this.name,
        this.address,
        this.logo,
        this.latitude,
        this.longitude,
        this.description,
        this.contactNo,
        this.headCoach,
        this.sessionTimings,
        this.weekDays,
        this.price,
        this.remarksPrice,
        this.skillLevel,
        this.academyJersey,
        this.capacity,
        this.remarksCurrentCapacity,
        this.sessionPlan,
        this.remarksSessionPlan,
        this.ageGroupOfStudents,
        this.remarksStudents,
        this.equipment,
        this.remarksOnEquipment,
        this.floodLights,
        this.groundSize,
        this.person,
        this.coachExperience,
        this.noOfAssistentCoach,
        this.assistentCoachName,
        this.feedbacks,
        this.amenitiesId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.amenitiesDetails,
        this.venueDetails});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    venueId = json['venue_id'];
    name = json['name'];
    address = json['address'];
    logo = json['logo'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    description = json['description'];
    contactNo = json['contact_no'];
    headCoach = json['head_coach'];
    sessionTimings = json['session_timings'];
    weekDays = json['week_days'];
    price = json['price'];
    remarksPrice = json['remarks_price'];
    skillLevel = json['skill_level'];
    academyJersey = json['academy_jersey'];
    capacity = json['capacity'];
    remarksCurrentCapacity = json['remarks_current_capacity'];
    sessionPlan = json['session_plan'];
    remarksSessionPlan = json['remarks_session_plan'];
    ageGroupOfStudents = json['age_group_of_students'];
    remarksStudents = json['remarks_students'];
    equipment = json['equipment'];
    remarksOnEquipment = json['remarks_on_equipment'];
    floodLights = json['flood_lights'];
    groundSize = json['ground_size'];
    person = json['person'];
    coachExperience = json['coach_experience'];
    noOfAssistentCoach = json['no_of_assistent_coach'];
    assistentCoachName = json['assistent_coach_name'];
    feedbacks = json['feedbacks'];
    amenitiesId = json['amenities_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    amenitiesDetails = json['amenities_details'];
    if (json['venue_details'] != null) {
      venueDetails = <VenueDetails>[];
      json['venue_details'].forEach((v) {
        venueDetails!.add(new VenueDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['venue_id'] = this.venueId;
    data['name'] = this.name;
    data['address'] = this.address;
    data['logo'] = this.logo;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['description'] = this.description;
    data['contact_no'] = this.contactNo;
    data['head_coach'] = this.headCoach;
    data['session_timings'] = this.sessionTimings;
    data['week_days'] = this.weekDays;
    data['price'] = this.price;
    data['remarks_price'] = this.remarksPrice;
    data['skill_level'] = this.skillLevel;
    data['academy_jersey'] = this.academyJersey;
    data['capacity'] = this.capacity;
    data['remarks_current_capacity'] = this.remarksCurrentCapacity;
    data['session_plan'] = this.sessionPlan;
    data['remarks_session_plan'] = this.remarksSessionPlan;
    data['age_group_of_students'] = this.ageGroupOfStudents;
    data['remarks_students'] = this.remarksStudents;
    data['equipment'] = this.equipment;
    data['remarks_on_equipment'] = this.remarksOnEquipment;
    data['flood_lights'] = this.floodLights;
    data['ground_size'] = this.groundSize;
    data['person'] = this.person;
    data['coach_experience'] = this.coachExperience;
    data['no_of_assistent_coach'] = this.noOfAssistentCoach;
    data['assistent_coach_name'] = this.assistentCoachName;
    data['feedbacks'] = this.feedbacks;
    data['amenities_id'] = this.amenitiesId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['amenities_details'] = this.amenitiesDetails;
    if (this.venueDetails != null) {
      data['venue_details'] =
          this.venueDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VenueDetails {
  String? id;
  String? userId;
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

  VenueDetails(
      {this.id,
        this.userId,
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

  VenueDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
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
    data['user_id'] = this.userId;
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
