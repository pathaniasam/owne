class MyProfileResponse {
  MyData? data;

  MyProfileResponse({this.data});

  MyProfileResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new MyData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class MyData {
  String? email;
  String? name;
  String? mobile;
  int? id;
  bool? isActive;
  bool? isLoggedIn;
  String? profileImage;
  String? createdAt;

  MyData(
      {this.email,
        this.name,
        this.mobile,
        this.id,
        this.isActive,
        this.isLoggedIn,
        this.profileImage,
        this.createdAt});

  MyData.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    mobile = json['mobile'];
    id = json['id'];
    isActive = json['isActive'];
    isLoggedIn = json['isLoggedIn'];
    profileImage = json['profileImage'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['id'] = this.id;
    data['isActive'] = this.isActive;
    data['isLoggedIn'] = this.isLoggedIn;
    data['profileImage'] = this.profileImage;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
