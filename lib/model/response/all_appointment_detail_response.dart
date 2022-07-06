class AllAppointemntDetailData {
  int? id;
  String? timing;
  String? type;
  String? totalAmount;
  String? currency;
  String? subTotal;
  String? promocode;
  String? discount;
  String? status;
  String? notes;
  PetDetail? petDetail;
  String? reason;
  List<DServices>? services;
  Professional? professional;
  String? userProfileImage;

  AllAppointemntDetailData(
      {this.id,
        this.timing,
        this.type,
        this.totalAmount,
        this.currency,
        this.subTotal,
        this.promocode,
        this.discount,
        this.status,
        this.notes,
        this.petDetail,
        this.reason,
        this.services,
        this.professional,
        this.userProfileImage});

  AllAppointemntDetailData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    timing = json['timing'];
    type = json['type'];
    totalAmount = json['totalAmount'];
    currency = json['currency'];
    subTotal = json['subTotal'];
    promocode = json['promocode'];
    discount = json['discount'];
    status = json['status'];
    notes = json['notes'];
    petDetail = json['petDetail'] != null
        ? new PetDetail.fromJson(json['petDetail'])
        : null;
    reason = json['reason'];
    if (json['services'] != null) {
      services = <DServices>[];
      json['services'].forEach((v) {
        services!.add(new DServices.fromJson(v));
      });
    }
    professional = json['professional'] != null
        ? new Professional.fromJson(json['professional'])
        : null;
    userProfileImage = json['userProfileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['timing'] = this.timing;
    data['type'] = this.type;
    data['totalAmount'] = this.totalAmount;
    data['currency'] = this.currency;
    data['subTotal'] = this.subTotal;
    data['promocode'] = this.promocode;
    data['discount'] = this.discount;
    data['status'] = this.status;
    data['notes'] = this.notes;
    if (this.petDetail != null) {
      data['petDetail'] = this.petDetail!.toJson();
    }
    data['reason'] = this.reason;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    if (this.professional != null) {
      data['professional'] = this.professional!.toJson();
    }
    data['userProfileImage'] = this.userProfileImage;
    return data;
  }
}

class PetDetail {
  String? petName;
  String? species;
  String? breed;
  String? gender;
  String? dob;
  int? weight;

  PetDetail(
      {this.petName,
        this.species,
        this.breed,
        this.gender,
        this.dob,
        this.weight});

  PetDetail.fromJson(Map<String, dynamic> json) {
    petName = json['petName'];
    species = json['species'];
    breed = json['breed'];
    gender = json['gender'];
    dob = json['dob'];
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['petName'] = this.petName;
    data['species'] = this.species;
    data['breed'] = this.breed;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['weight'] = this.weight;
    return data;
  }
}

class DServices {
  String? name;
  String? price;
  String? priceType;
  String? currency;

  DServices({this.name, this.price, this.priceType, this.currency});

  DServices.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    priceType = json['priceType'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['priceType'] = this.priceType;
    data['currency'] = this.currency;
    return data;
  }
}

class Professional {
  String? lat;
  String? lng;
  User? user;

  Professional({this.lat, this.lng, this.user});

  Professional.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? profileImage;
  String? name;

  User({this.profileImage, this.name});

  User.fromJson(Map<String, dynamic> json) {
    profileImage = json['profileImage'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profileImage'] = this.profileImage;
    data['name'] = this.name;
    return data;
  }
}
