class AllOrdersResponse {
  bool? status;
  String? message;
  List<Data>? data;

  AllOrdersResponse({this.status, this.message, this.data});

  AllOrdersResponse.fromJson(Map<String, dynamic> json) {
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
  String? partnerId;
  String? type;
  String? orderDate;
  String? facilityBookingId;
  String? sessionId;
  String? tournamentId;
  String? amount;
  String? transactionId;
  String? experienceId;
  String? status;
  String? createdAt;
  String? updatedAt;
  Facility? facility;
  String? facilityaddress;
  FacilityBooking? facilityBooking;
  Tournament? tournament;
  String? venu_name;
  Experience? experience;
  User? user;
  Academy? academy;

  Data(
      {this.id,
      this.userId,
      this.partnerId,
      this.type,
      this.orderDate,
      this.facilityBookingId,
      this.sessionId,
      this.tournamentId,
      this.amount,
      this.facilityBooking,
      this.transactionId,
      this.experienceId,
      this.status,
      this.venu_name,
      this.facilityaddress,
      this.createdAt,
      this.updatedAt,
      this.facility,
      this.tournament,
      this.experience,
      this.user,
      this.academy});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    partnerId = json['partner_id'];
    type = json['type'];
    orderDate = json['order_date'];
    facilityBookingId = json['facility_booking_id'];
    sessionId = json['session_id'];
    tournamentId = json['tournament_id'];
    amount = json['amount'];
    transactionId = json['transaction_id'];
    experienceId = json['experience_id'];
    facilityaddress = json['facility_address'];
    venu_name = json['venu_name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    facilityBooking = json['facility_booking'] != null
        ? new FacilityBooking.fromJson(json['facility_booking'])
        : null;
    facility = json['facility'] != null
        ? new Facility.fromJson(json['facility'])
        : null;
    tournament = json['tournament'] != null
        ? new Tournament.fromJson(json['tournament'])
        : null;
    experience = json['experience'] != null
        ? new Experience.fromJson(json['experience'])
        : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    academy =
        json['academy'] != null ? new Academy.fromJson(json['academy']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['partner_id'] = this.partnerId;
    data['type'] = this.type;
    data['order_date'] = this.orderDate;
    data['facility_booking_id'] = this.facilityBookingId;
    data['session_id'] = this.sessionId;
    data['tournament_id'] = this.tournamentId;
    data['amount'] = this.amount;
    data['facility_address'] = this.facilityaddress;
    data['transaction_id'] = this.transactionId;
    data['experience_id'] = this.experienceId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.facilityBooking != null) {
      data['facility_booking'] = this.facilityBooking!.toJson();
    }
    if (this.facility != null) {
      data['facility'] = this.facility!.toJson();
    }
    if (this.tournament != null) {
      data['tournament'] = this.tournament!.toJson();
    }
    if (this.experience != null) {
      data['experience'] = this.experience!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.academy != null) {
      data['academy'] = this.academy!.toJson();
    }
    return data;
  }
}

class Facility {
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

  Facility(
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

  Facility.fromJson(Map<String, dynamic> json) {
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

class FacilityBooking {
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

  FacilityBooking(
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
      this.updatedAt});

  FacilityBooking.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class Tournament {
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
  String? status;
  String? createdAt;
  String? updatedAt;

  Tournament(
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
      this.status,
      this.createdAt,
      this.updatedAt});

  Tournament.fromJson(Map<String, dynamic> json) {
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
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Experience {
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
  String? updatedAt;

  Experience(
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
      this.updatedAt});

  Experience.fromJson(Map<String, dynamic> json) {
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
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
  String? image;
  String? status;
  String? encryptPassword;
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

class Academy {
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

  Academy(
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

  Academy.fromJson(Map<String, dynamic> json) {
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
