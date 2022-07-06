class AllDealsResponse {
  List<AllDealsData>? data;
  PageInfo? pageInfo;

  AllDealsResponse({this.data, this.pageInfo});

  AllDealsResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <AllDealsData>[];
      json['data'].forEach((v) {
        data!.add(new AllDealsData.fromJson(v));
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

class AllDealsData {
  int? id;
  String? promocode;
  int? professional_id;
  String? expiry;
  String? description;
  int? discount;
  String? name;
  String? profileImage;
  String? address;
  String? openTime;
  String? closeTime;
  double? distance;

  AllDealsData(
      {this.id,
        this.professional_id,
        this.promocode,
        this.expiry,
        this.description,
        this.discount,
        this.name,
        this.profileImage,
        this.address,
        this.openTime,
        this.closeTime,
        this.distance});

  AllDealsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    professional_id = json['professional_id'];
    promocode = json['promocode'];
    expiry = json['expiry'];
    description = json['description'];
    discount = json['discount'];
    name = json['name'];
    profileImage = json['profile_image'];
    address = json['address'];
    openTime = json['open_time'];
    closeTime = json['close_time'];
    distance = json['distance'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['professional_id'] = this.professional_id;
    data['promocode'] = this.promocode;
    data['expiry'] = this.expiry;
    data['description'] = this.description;
    data['discount'] = this.discount;
    data['name'] = this.name;
    data['profile_image'] = this.profileImage;
    data['address'] = this.address;
    data['open_time'] = this.openTime;
    data['close_time'] = this.closeTime;
    data['distance'] = this.distance;
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
