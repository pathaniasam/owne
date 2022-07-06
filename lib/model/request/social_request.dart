class SocialRequest {
  String? email;
  String? name;
  String? accountSource;
  String? image;

  SocialRequest({this.email, this.name, this.accountSource, this.image});

  SocialRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    accountSource = json['account_source'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['account_source'] = this.accountSource;
    data['image'] = this.image;
    return data;
  }
}
