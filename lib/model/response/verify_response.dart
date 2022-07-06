class VerifyResponse {
  String? message;
  int? discount;

  VerifyResponse({this.message, this.discount});

  VerifyResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['discount'] = this.discount;
    return data;
  }
}
