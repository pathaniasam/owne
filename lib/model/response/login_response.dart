class LoginResponse {
  int? id;
  String? name;
  String? role;
  String? token;
  String? message;
  String? profile_image;

  LoginResponse({this.id, this.name, this.role, this.token,this.message,this.profile_image});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    role = json['role'];
    token = json['token'];
    message = json['message'];
    profile_image = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['role'] = this.role;
    data['token'] = this.token;
    data['message'] = this.message;
    data['profile_image'] = this.profile_image;
    return data;
  }
}
