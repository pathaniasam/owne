class CategoryFilterResponse {
  Professionals? professionals;

  CategoryFilterResponse({this.professionals});

  CategoryFilterResponse.fromJson(Map<String, dynamic> json) {
    professionals = json['professionals'] != null
        ? new Professionals.fromJson(json['professionals'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.professionals != null) {
      data['professionals'] = this.professionals!.toJson();
    }
    return data;
  }
}

class Professionals {
  List<CategoryData>? data;
  PageInfo? pageInfo;

  Professionals({this.data, this.pageInfo});

  Professionals.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CategoryData>[];
      json['data'].forEach((v) {
        data!.add(new CategoryData.fromJson(v));
      });
    }
    pageInfo = json['page_info'] != null
        ? new PageInfo.fromJson(json['page_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.pageInfo != null) {
      data['page_info'] = this.pageInfo!.toJson();
    }
    return data;
  }
}

class CategoryData {
  int? id;
  String? name;
  String? profileImage;
  String? address;
  double? lat;
  double? lng;
  String? openTime;
  String? closeTime;
  double? distance;
  int? totalServices;
  int? rating;

  CategoryData(
      {this.id,
        this.name,
        this.profileImage,
        this.address,
        this.lat,
        this.lng,
        this.openTime,
        this.closeTime,
        this.distance,
        this.totalServices,
        this.rating});

  CategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profileImage = json['profile_image'];
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
    openTime = json['open_time'];
    closeTime = json['close_time'];
    distance = json['distance'];
    totalServices = json['total_services'];
    rating = json['rating'];
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
    data['distance'] = this.distance;
    data['total_services'] = this.totalServices;
    data['rating'] = this.rating;
    return data;
  }
}

class PageInfo {
  String? nextPageUrl;
  bool? hasMoreData;

  PageInfo({this.nextPageUrl, this.hasMoreData});

  PageInfo.fromJson(Map<String, dynamic> json) {
    nextPageUrl = json['next_page_url'];
    hasMoreData = json['has_more_data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['next_page_url'] = this.nextPageUrl;
    data['has_more_data'] = this.hasMoreData;
    return data;
  }
}
