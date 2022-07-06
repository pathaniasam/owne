class AllCategoriesResponse {
  List<Categories>? categories;
  List<String>? paymentModes;

  AllCategoriesResponse({this.categories, this.paymentModes});

  AllCategoriesResponse.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    paymentModes = json['payment_modes'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    data['payment_modes'] = this.paymentModes;
    return data;
  }
}

class Categories {
  String? name;
  int? id;

  Categories({this.name, this.id});

  Categories.fromJson(Map<String, dynamic> json) {
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
