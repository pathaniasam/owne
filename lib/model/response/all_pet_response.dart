class AllPetResponse {
  List<Pets>? pets;

  AllPetResponse({this.pets});

  AllPetResponse.fromJson(Map<String, dynamic> json) {
    if (json['pets'] != null) {
      pets = <Pets>[];
      json['pets'].forEach((v) {
        pets!.add(new Pets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pets != null) {
      data['pets'] = this.pets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pets {
  int? id;
  int? userId;
  String? petName;
  String? species;
  String? breed;
  String? gender;
  String? dob;
  double? weight;
  String? image;
  String? createdAt;

  Pets(
      {this.id,
        this.userId,
        this.petName,
        this.species,
        this.breed,
        this.gender,
        this.dob,
        this.weight,
        this.image,
        this.createdAt});

  Pets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    petName = json['petName'];
    species = json['species'];
    breed = json['breed'];
    gender = json['gender'];
    image = json['profileImage'];
    dob = json['dob'];
    weight = json['weight'].toDouble();
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['petName'] = this.petName;
    data['species'] = this.species;
    data['breed'] = this.breed;
    data['profileImage'] = this.image;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['weight'] = this.weight;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
