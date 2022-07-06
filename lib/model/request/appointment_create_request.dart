class AppointmentCreateRequest {
  int? professionalId;
  String? timing;
  String? type;
  String? notes;
  int? petId;
  List<CreateServices>? services;
  double? totalAmount;
  double? sub_total;
  double? discount;
  String? currency;
  String? promocode;

  AppointmentCreateRequest(
      {this.professionalId,
        this.timing,
        this.type,
        this.notes,
        this.petId,
        this.services,
        this.totalAmount,
        this.discount,
        this.currency,this.sub_total,this.promocode});

  AppointmentCreateRequest.fromJson(Map<String, dynamic> json) {
    professionalId = json['professional_id'];
    timing = json['timing'];
    type = json['type'];
    notes = json['notes'];
    petId = json['pet_id'];
    discount = json['discount'];
    if (json['services'] != null) {
      services = <CreateServices>[];
      json['services'].forEach((v) {
        services!.add(new CreateServices.fromJson(v));
      });
    }
    totalAmount = json['total_amount'];
    sub_total = json['sub_total'];
    currency = json['currency'];
    promocode = json['promocode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['professional_id'] = this.professionalId;
    data['timing'] = this.timing;
    data['type'] = this.type;
    data['notes'] = this.notes;
    data['pet_id'] = this.petId;
    data['discount'] = this.discount;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    data['total_amount'] = this.totalAmount;
    data['sub_total'] = this.sub_total;
    data['currency'] = this.currency;
    data['promocode'] = this.promocode;
    return data;
  }
}

class CreateServices {
  int? professionalServiceId;
  String? name;
  int? price;
  String? priceType;
  String? currency;

  CreateServices(
      {this.professionalServiceId,
        this.name,
        this.price,
        this.priceType,
        this.currency});

  CreateServices.fromJson(Map<String, dynamic> json) {
    professionalServiceId = json['professionalServiceId'];
    name = json['name'];
    price = json['price'];
    priceType = json['priceType'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['professionalServiceId'] = this.professionalServiceId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['priceType'] = this.priceType;
    data['currency'] = this.currency;
    return data;
  }
}
