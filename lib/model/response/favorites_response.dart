class FavouriteResponse {
  List<ProfessionalsFav>? professionals;

  FavouriteResponse({this.professionals});

  FavouriteResponse.fromJson(Map<String, dynamic> json) {
    if (json['professionals'] != null) {
      professionals = <ProfessionalsFav>[];
      json['professionals'].forEach((v) {
        professionals!.add(new ProfessionalsFav.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.professionals != null) {
      data['professionals'] =
          this.professionals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProfessionalsFav {
  int? id;
  String? name;
  String? profileImage;
  String? address;
  double? lat;
  double? lng;
  String? openTime;
  String? closeTime;
  int? totalServices;
  int? rating;
  bool? isFav=true;

  ProfessionalsFav(
      {this.id,
        this.name,
        this.profileImage,
        this.address,
        this.lat,
        this.lng,
        this.openTime,
        this.closeTime,
        this.totalServices,
        this.rating,this.isFav});

  ProfessionalsFav.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profileImage = json['profile_image'];
    address = json['address'];
    lat = json['lat'].toDouble();
    lng = json['lng'].toDouble();
    openTime = json['open_time'];
    closeTime = json['close_time'];
    totalServices = json['total_services'];
    rating = json['rating'];
    isFav = json['isFav'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['profile_image'] = this.profileImage;
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['open_time'] = this.openTime;
    data['close_time'] = this.closeTime;
    data['total_services'] = this.totalServices;
    data['rating'] = this.rating;
    data['isFav'] = this.isFav;
    return data;
  }
}
