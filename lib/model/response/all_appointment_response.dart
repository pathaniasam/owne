class AllAppointmentResponse {
    List<AllAppointmentData>? data;
  PageInfo? pageInfo;

  AllAppointmentResponse({this.data, this.pageInfo});

  AllAppointmentResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <AllAppointmentData>[];
      json['data'].forEach((v) {
        data!.add(new AllAppointmentData.fromJson(v));
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

class AllAppointmentData {
  int? id;
  String? timing;
  String? type;
  String? status;
  List<Services>? services;
  Professional? professional;

  AllAppointmentData({this.id, this.timing, this.type, this.services, this.professional});

  AllAppointmentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    timing = json['timing'];
    type = json['type'];
    status = json['status'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
    professional = json['professional'] != null
        ? new Professional.fromJson(json['professional'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['timing'] = this.timing;
    data['type'] = this.type;
    data['status'] = this.status;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    if (this.professional != null) {
      data['professional'] = this.professional!.toJson();
    }
    return data;
  }
}

class Services {
  String? name;
  String? price;
  String? priceType;
  String? currency;

  Services({this.name, this.price, this.priceType, this.currency});

  Services.fromJson(Map<String, dynamic> json) {
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
  User? user;

  Professional({this.user});

  Professional.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? name;
  String? profileImage;

  User({this.name,this.profileImage});

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

class PageInfo {
  String? nextPageUrl;
  String? prevPageUrl;
  int? totalCount;
  bool? hasMoreData;

  PageInfo(
      {this.nextPageUrl, this.prevPageUrl, this.totalCount, this.hasMoreData});

  PageInfo.fromJson(Map<String, dynamic> json) {
    nextPageUrl = json['next_page_url'];
    prevPageUrl = json['prev_page_url'];
    totalCount = json['total_count'];
    hasMoreData = json['has_more_data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['next_page_url'] = this.nextPageUrl;
    data['prev_page_url'] = this.prevPageUrl;
    data['total_count'] = this.totalCount;
    data['has_more_data'] = this.hasMoreData;
    return data;
  }
}
