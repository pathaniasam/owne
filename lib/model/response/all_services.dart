class AllServices {
  List<ServicesData>? data;

  AllServices({this.data});

  AllServices.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ServicesData>[];
      json['data'].forEach((v) {
        data!.add(new ServicesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServicesData {
  String? name;
  int? id;
  List<SubServices>? subServices;

  ServicesData({this.name, this.id, this.subServices});

  ServicesData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    if (json['sub_services'] != null) {
      subServices = <SubServices>[];
      json['sub_services'].forEach((v) {
        subServices!.add(new SubServices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    if (this.subServices != null) {
      data['sub_services'] = this.subServices!.map((v) => v.toJson()).toList();
    }else{
      data['sub_services']=null;
    }
    return data;
  }
}

class SubServices {
  String? name;
  int? id;

  SubServices({this.name, this.id});

  SubServices.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}
