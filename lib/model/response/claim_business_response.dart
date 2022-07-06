class ClaimBusinessResponse {
  String? message;
  int? id;
  String? name;
  String? token;
  String? country;

  ClaimBusinessResponse({this.message, this.id, this.name, this.token});

  ClaimBusinessResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    id = json['id'];
    name = json['name'];
    token = json['token'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['id'] = this.id;
    data['name'] = this.name;
    data['token'] = this.token;
    data['country'] = this.country;
    return data;
  }
}
