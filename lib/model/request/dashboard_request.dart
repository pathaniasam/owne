class DashbaordRequest {
  String? latitude;
  String? longitude;
  String? name;
  String? type;
  String? categoryId;
  String? payment;
  int? rating;

  DashbaordRequest({this.latitude, this.longitude,this.name,this.type,this.categoryId,this.payment,this.rating});

  DashbaordRequest.fromJson(Map<String, dynamic> json) {
    latitude = json['location'];
    longitude = json['longitude'];
    name = json['name'];
    type = json['type'];
    categoryId = json['categoryId'];
    payment= json['payment'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    if(data['name']!=null){
      data['name'] = this.name;
    }

    data['type'] = this.type;
    data['categoryId'] = this.categoryId;
    data['rating'] = this.rating;
    data['payment'] = this.payment;
    return data;
  }
}
