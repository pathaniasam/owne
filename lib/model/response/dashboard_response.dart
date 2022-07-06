class DashboardReponse {
  List<Categories>? categories;
  Professionals? professionals;

  DashboardReponse({this.categories, this.professionals});

  DashboardReponse.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    professionals = json['professionals'] != null
        ? new Professionals.fromJson(json['professionals'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.professionals != null) {
      data['professionals'] = this.professionals!.toJson();
    }
    return data;
  }
}

class Categories {
  int? id;
  String? name;
  String? image;

  Categories({this.id, this.name, this.image});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}

class Professionals {
  List<HomeData>? data;
  PageInfo? pageInfo;

  Professionals({this.data, this.pageInfo});

  Professionals.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <HomeData>[];
      json['data'].forEach((v) {
        data!.add(new HomeData.fromJson(v));
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

class HomeData {
  int? id;
  int? price;
  String? name;
  String? profileImage;
  String? currency;
  String? address;
  String? openTime;
  String? closeTime;
  double? distance;
  double? lat;
  double? lng;
  String? days;
  String? price_type;
  int? rating;

  HomeData(
      {this.id,
        this.name,
        this.profileImage,
        this.address,
        this.openTime,
        this.closeTime,
        this.days,
        this.distance,this.lat,this.lng,this.rating,this.price,this.currency,this.price_type});

  HomeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profileImage = json['profile_image'];
    address = json['address'];
    openTime = json['open_time'];
    closeTime = json['close_time'];
    distance = json['distance'];
    lat = json['lat'];
    lng = json['lng'];
    days = json['days'];
    rating = json['rating'];
    price = json['price'];
    currency = json['currency'];
    price_type = json['price_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['profile_image'] = this.profileImage;
    data['address'] = this.address;
    data['open_time'] = this.openTime;
    data['close_time'] = this.closeTime;
    data['distance'] = this.distance;
    data['lng'] = this.lng;
    data['lat'] = this.lat;
    data['days'] = this.days;
    data['rating'] = this.rating;
    data['price'] = this.price;
    data['currency'] = this.currency;
    data['price_type'] = this.price_type;
    return data;
  }
}

class PageInfo {
  String? nextPageUrl;
  int? totalCount;
  bool? hasMoreData;

  PageInfo({this.nextPageUrl, this.totalCount, this.hasMoreData});

  PageInfo.fromJson(Map<String, dynamic> json) {
    nextPageUrl = json['next_page_url'];
    totalCount = json['total_count'];
    hasMoreData = json['has_more_data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['next_page_url'] = this.nextPageUrl;
    data['total_count'] = this.totalCount;
    data['has_more_data'] = this.hasMoreData;
    return data;
  }
}
