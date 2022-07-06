class SlotResponse {
  List<String>? slots;

  SlotResponse({this.slots});

  SlotResponse.fromJson(Map<String, dynamic> json) {
    slots = json['slots'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slots'] = this.slots;
    return data;
  }
}
