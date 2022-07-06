class TakeSubscriptionRequest {
  String? planId;
  String? token;

  TakeSubscriptionRequest({this.planId, this.token});

  TakeSubscriptionRequest.fromJson(Map<String, dynamic> json) {
    planId = json['plan_id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plan_id'] = this.planId;
    data['token'] = this.token;
    return data;
  }
}
