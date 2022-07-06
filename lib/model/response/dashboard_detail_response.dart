class DashBoardDetailResponse {
  String? uid;
  String? placeId;
  String? name;
  String? ownerName;
  String? formattedAddress;
  String? formattedPhoneNumber;
  bool? isClaimed;
  String? priceLevel;
  double? latitude;
  double? longitude;
  String? picture;
  List<OpeningHours>? openingHours;
  bool? openNow;

  DashBoardDetailResponse(
      {this.uid,
        this.placeId,
        this.name,
        this.ownerName,
        this.formattedAddress,
        this.formattedPhoneNumber,
        this.isClaimed,
        this.priceLevel,
        this.latitude,
        this.longitude,
        this.picture,
        this.openingHours,
        this.openNow,
       });

  DashBoardDetailResponse.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    placeId = json['place_id'];
    name = json['name'];
    ownerName = json['owner_name'];
    formattedAddress = json['formatted_address'];
    formattedPhoneNumber = json['formatted_phone_number'];
    isClaimed = json['is_claimed'];
    priceLevel = json['price_level'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    picture = json['picture'];
    if (json['opening_hours'] != null) {
      openingHours = <OpeningHours>[];
      json['opening_hours'].forEach((v) {
        openingHours!.add(new OpeningHours.fromJson(v));
      });
    }
    openNow = json['open_now'];
    if (json['services'] != null) {

    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['place_id'] = this.placeId;
    data['name'] = this.name;
    data['owner_name'] = this.ownerName;
    data['formatted_address'] = this.formattedAddress;
    data['formatted_phone_number'] = this.formattedPhoneNumber;
    data['is_claimed'] = this.isClaimed;
    data['price_level'] = this.priceLevel;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['picture'] = this.picture;
    if (this.openingHours != null) {
      data['opening_hours'] = this.openingHours!.map((v) => v.toJson()).toList();
    }
    data['open_now'] = this.openNow;

    return data;
  }
}

class OpeningHours {
  int? day;
  String? openingTime;
  String? closingTime;

  OpeningHours({this.day, this.openingTime, this.closingTime});

  OpeningHours.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    openingTime = json['opening_time'];
    closingTime = json['closing_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['opening_time'] = this.openingTime;
    data['closing_time'] = this.closingTime;
    return data;
  }
}
