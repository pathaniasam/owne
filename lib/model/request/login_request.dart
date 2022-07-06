class LoginRequest {
  String? email;
  String? password;
  String? accountSource;

  LoginRequest({this.email, this.password, this.accountSource});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    accountSource = json['account_source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['account_source'] = this.accountSource;
    return data;
  }
}
