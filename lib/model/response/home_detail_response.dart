class HomeDetailResponse {
  String? address;
  String? tagline;
  String? openTime;
  String? closeTime;
  String? website;
  String? contact;
  String? lat;
  String? lng;
  int? avgRating;
  bool? claimed;
  bool? isFavourite;
  List<String>? paymentModes;
  User? user;
  List<Services>? services;

  HomeDetailResponse(
      {this.address,
        this.tagline,
        this.openTime,
        this.closeTime,
        this.website,
        this.contact,
        this.paymentModes,
        this.user,
        this.claimed,
        this.lat,
        this.lng,
        this.isFavourite,
        this.services,this.avgRating});

  HomeDetailResponse.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    tagline = json['tagline'];
    openTime = json['openTime'];
    closeTime = json['closeTime'];
    website = json['website'];
    contact = json['contact'];
    claimed = json['claimed'];
    claimed = json['claimed'];
    avgRating = json['avgRating'];
    isFavourite = json['isFavourite'];
    lat = json['lat'];
    lng = json['lng'];
    paymentModes = json['paymentModes'].cast<String>();
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['tagline'] = this.tagline;
    data['openTime'] = this.openTime;
    data['closeTime'] = this.closeTime;
    data['website'] = this.website;
    data['contact'] = this.contact;
    data['claimed'] = this.claimed;
    data['avgRating'] = this.avgRating;
    data['isFavourite'] = this.isFavourite;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['paymentModes'] = this.paymentModes;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  String? name;
  String? profileImage;

  User({this.name, this.profileImage});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['profileImage'] = this.profileImage;
    return data;
  }
}

class Services {
  int? price;
  int? id;
  String? priceType;
  String? currency;
  String? animalType;
  String? description;
  Service? service;
  bool? isTrue=false;

  Services(
      {this.price,
        this.id,
        this.priceType,
        this.currency,
        this.animalType,
        this.description,
        this.service,this.isTrue=false});

  Services.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    id = json['id'];
    priceType = json['priceType'];
    currency = json['currency'];
    animalType = json['animalType'];
    description = json['description'];
    isTrue = json['isTrue'];
    service =
    json['service'] != null ? new Service.fromJson(json['service']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['id'] = this.id;
    data['priceType'] = this.priceType;
    data['currency'] = this.currency;
    data['animalType'] = this.animalType;
    data['description'] = this.description;
    data['isTrue'] = this.isTrue;
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    return data;
  }
}

class Service {
  String? name;
  String? image;

  Service({this.name, this.image});

  Service.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}
