class AddCostRequest {
  int? professionalServiceId;
  int? professionalId;
  double? price;
  String? currency;

  AddCostRequest(
      {this.professionalServiceId,
        this.professionalId,
        this.price,
        this.currency});

  AddCostRequest.fromJson(Map<String, dynamic> json) {
    professionalServiceId = json['professional_service_id'];
    professionalId = json['professional_id'];
    price = json['price'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['professional_service_id'] = this.professionalServiceId;
    data['professional_id'] = this.professionalId;
    data['price'] = this.price;
    data['currency'] = this.currency;
    return data;
  }
}
