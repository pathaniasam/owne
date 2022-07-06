class service_response {
  String? name;
  String? description;
  int? order;
  List<Services>? services;

  service_response({this.name, this.description, this.order, this.services});

  service_response.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    order = json['order'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['order'] = this.order;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Services {
  String? shortName;
  String? longName;
  String? pet;
  int? order;
  String? longDescription;
  Null? shortDescription;

  Services(
      {this.shortName,
        this.longName,
        this.pet,
        this.order,
        this.longDescription,
        this.shortDescription});

  Services.fromJson(Map<String, dynamic> json) {
    shortName = json['short_name'];
    longName = json['long_name'];
    pet = json['pet'];
    order = json['order'];
    longDescription = json['long_description'];
    shortDescription = json['short_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['short_name'] = this.shortName;
    data['long_name'] = this.longName;
    data['pet'] = this.pet;
    data['order'] = this.order;
    data['long_description'] = this.longDescription;
    data['short_description'] = this.shortDescription;
    return data;
  }
}
