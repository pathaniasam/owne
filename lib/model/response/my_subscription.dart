class MySubscription {
  Subscription? subscription;

  MySubscription({this.subscription});

  MySubscription.fromJson(Map<String, dynamic> json) {
    subscription = json['subscription'] != null
        ? new Subscription.fromJson(json['subscription'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subscription != null) {
      data['subscription'] = this.subscription!.toJson();
    }
    return data;
  }
}

class Subscription {
  int? id;
  int? userId;
  String? planId;
  String? planName;
  String? planPrice;
  String? planCurrency;
  String? productId;
  String? subscriptionId;
  String? planValidity;
  String? validityStartFrom;
  String? createdAt;
  String? validityEndOn;

  Subscription(
      {this.id,
        this.userId,
        this.planId,
        this.planName,
        this.planPrice,
        this.planCurrency,
        this.productId,
        this.subscriptionId,
        this.planValidity,
        this.validityStartFrom,
        this.createdAt,
        this.validityEndOn});

  Subscription.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    planId = json['planId'];
    planName = json['planName'];
    planPrice = json['planPrice'];
    planCurrency = json['planCurrency'];
    productId = json['productId'];
    subscriptionId = json['subscriptionId'];
    planValidity = json['planValidity'];
    validityStartFrom = json['validityStartFrom'];
    createdAt = json['createdAt'];
    validityEndOn = json['validityEndOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['planId'] = this.planId;
    data['planName'] = this.planName;
    data['planPrice'] = this.planPrice;
    data['planCurrency'] = this.planCurrency;
    data['productId'] = this.productId;
    data['subscriptionId'] = this.subscriptionId;
    data['planValidity'] = this.planValidity;
    data['validityStartFrom'] = this.validityStartFrom;
    data['createdAt'] = this.createdAt;
    data['validityEndOn'] = this.validityEndOn;
    return data;
  }
}
