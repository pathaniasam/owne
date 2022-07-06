class VerfiyRequest {
  int? professionalId;
  String? promocode;
  List<int>? services;

  VerfiyRequest({this.professionalId, this.promocode, this.services});

  VerfiyRequest.fromJson(Map<String, dynamic> json) {
    professionalId = json['professional_id'];
    promocode = json['promocode'];
    services = json['services'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['professional_id'] = this.professionalId;
    data['promocode'] = this.promocode;
    data['services'] = this.services;
    return data;
  }
}
