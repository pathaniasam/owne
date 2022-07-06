class PlansResponse {
  List<Plans>? plans;

  PlansResponse({this.plans});

  PlansResponse.fromJson(Map<String, dynamic> json) {
    if (json['plans'] != null) {
      plans = <Plans>[];
      json['plans'].forEach((v) { plans!.add(new Plans.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.plans != null) {
      data['plans'] = this.plans!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Plans {
  String? id;
  String? object;
  bool? active;
  String? billingScheme;
  int? created;
  String? currency;
  bool? livemode;
  String? nickname;
  String? product;
  Recurring? recurring;
  String? taxBehavior;
  String? type;
  int? unitAmount;
  String? unitAmountDecimal;

  Plans({this.id, this.object, this.active, this.billingScheme, this.created, this.currency, this.livemode, this.nickname, this.product, this.recurring, this.taxBehavior, this.type, this.unitAmount, this.unitAmountDecimal});

  Plans.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    object = json['object'];
    active = json['active'];
    billingScheme = json['billing_scheme'];
    created = json['created'];
    currency = json['currency'];
    livemode = json['livemode'];
    nickname = json['nickname'];
    product = json['product'];
    recurring = json['recurring'] != null ? new Recurring.fromJson(json['recurring']) : null;
    taxBehavior = json['tax_behavior'];
    type = json['type'];
    unitAmount = json['unit_amount'];
    unitAmountDecimal = json['unit_amount_decimal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['object'] = this.object;
    data['active'] = this.active;
    data['billing_scheme'] = this.billingScheme;
    data['created'] = this.created;
    data['currency'] = this.currency;
    data['livemode'] = this.livemode;

    data['nickname'] = this.nickname;
    data['product'] = this.product;
    if (this.recurring != null) {
      data['recurring'] = this.recurring!.toJson();
    }
    data['tax_behavior'] = this.taxBehavior;
    data['type'] = this.type;
    data['unit_amount'] = this.unitAmount;
    data['unit_amount_decimal'] = this.unitAmountDecimal;
    return data;
  }
}


Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  return data;

}

class Recurring {
  String? interval;
  int? intervalCount;
  String? usageType;

  Recurring({ this.interval, this.intervalCount, this.usageType});

  Recurring.fromJson(Map<String, dynamic> json) {
    interval = json['interval'];
    intervalCount = json['interval_count'];
    usageType = json['usage_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['interval'] = this.interval;
    data['interval_count'] = this.intervalCount;
    data['usage_type'] = this.usageType;
    return data;
  }
}
