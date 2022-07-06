class CategoriesResponse {
  List<Categorie>? categories;

  CategoriesResponse({this.categories});

  CategoriesResponse.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categorie>[];
      json['categories'].forEach((v) {
        categories!.add(new Categorie.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categorie {
  int? id;
  String? name;
  String? image;

  Categorie({this.id, this.name, this.image});

  Categorie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}
