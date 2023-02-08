class TournamentListResponse {
  bool? status;
  String? message;
  List<Data>? data;

  TournamentListResponse({this.status, this.message, this.data});

  TournamentListResponse.fromJson(Map<String, dynamic> json) {
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
  String? academyId;
  String? title;
  String? noOfTickets;
  String? ticketsLeft;
  String? price;
  String? startDate;
  String? endDate;
  String? description;
  String? type;
  String? image;
  String? url;
  String? approved;
  List<Sponsors>? sponsors;
  String? status;
  String? createdAt;
  String? updatedAt;
  bool? rating;
  List<AcademyDetails>? academyDetails;

  Data(
      {this.id,
        this.userId,
        this.academyId,
        this.title,
        this.noOfTickets,
        this.ticketsLeft,
        this.price,
        this.startDate,
        this.endDate,
        this.description,
        this.type,
        this.image,
        this.url,
        this.approved,
        this.sponsors,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.rating,
        this.academyDetails});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    academyId = json['academy_id'];
    title = json['title'];
    noOfTickets = json['no_of_tickets'];
    ticketsLeft = json['tickets_left'];
    price = json['price'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    description = json['description'];
    type = json['type'];
    image = json['image'];
    url = json['url'];
    approved = json['approved'];
    if (json['sponsors'] != null) {
      sponsors = <Sponsors>[];
      json['sponsors'].forEach((v) {
        sponsors!.add(new Sponsors.fromJson(v));
      });
    }
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    rating = json['rating'];
    if (json['academy_details'] != null) {
      academyDetails = <AcademyDetails>[];
      json['academy_details'].forEach((v) {
        academyDetails!.add(new AcademyDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['academy_id'] = this.academyId;
    data['title'] = this.title;
    data['no_of_tickets'] = this.noOfTickets;
    data['tickets_left'] = this.ticketsLeft;
    data['price'] = this.price;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['description'] = this.description;
    data['type'] = this.type;
    data['image'] = this.image;
    data['url'] = this.url;
    data['approved'] = this.approved;
    if (this.sponsors != null) {
      data['sponsors'] = this.sponsors!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['rating'] = this.rating;
    if (this.academyDetails != null) {
      data['academy_details'] =
          this.academyDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sponsors {
  String? id;
  String? name;
  String? website;
  String? contact;
  String? status;
  String? createdAt;
  String? updatedAt;

  Sponsors(
      {this.id,
        this.name,
        this.website,
        this.contact,
        this.status,
        this.createdAt,
        this.updatedAt});

  Sponsors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    website = json['website'];
    contact = json['contact'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['website'] = this.website;
    data['contact'] = this.contact;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class AcademyDetails {
  String? id;
  String? userId;
  String? venueId;
  String? name;
  String? address;
  String? logo;
  String? latitude;
  String? longitude;
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
  String? amenitiesId;
  String? status;
  String? createdAt;
  String? updatedAt;

  AcademyDetails(
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
        this.updatedAt});

  AcademyDetails.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
