class AddPetRequest {
  String? petName;
  String? species;
  String? breed;
  String? gender;
  String? dob;
  int? weight;

  AddPetRequest(
      {this.petName,
        this.species,
        this.breed,
        this.gender,
        this.dob,
        this.weight});

  AddPetRequest.fromJson(Map<String, dynamic> json) {
    petName = json['petName'];
    species = json['species'];
    breed = json['breed'];
    gender = json['gender'];
    dob = json['dob'];
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['petName'] = this.petName;
    data['species'] = this.species;
    data['breed'] = this.breed;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['weight'] = this.weight;
    return data;
  }
}
