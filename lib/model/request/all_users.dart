class AllUsers {
  String? senderId;
  String? receiverId;
  String? senderName;
  String? reciverName;
  String? senderImage;
  String? timpstamp;
  String? type;
  String? doctorType;

  AllUsers({this.senderId, this.receiverId,this.reciverName,this.senderName,this.senderImage,this.timpstamp,this.type,this.doctorType});

  AllUsers.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    senderName = json['senderName'];
    reciverName = json['reciverName'];
    senderImage = json['senderImage'];
    timpstamp = json['timpstamp'];
    type = json['type'];
    doctorType = json['doctorType'];
  }

  AllUsers.fromMap(Map<dynamic, dynamic> mapData) {
    this.senderId = mapData['senderUid'];
    this.receiverId = mapData['receiverId'];
    this.senderName = mapData['senderName'];
    this.reciverName = mapData['reciverName'];
    this.senderImage = mapData['senderImage'];
    this.timpstamp = mapData['timpstamp'];
    this.type = mapData['type'];
    this.doctorType = mapData['doctorType'];

  }



  Map<String,dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['senderId'] = this.senderId;
    map['receiverId'] = this.receiverId;
    map['senderName'] = this.senderName;
    map['reciverName'] = this.reciverName;
    map['senderImage'] = this.senderImage;
    map['timpstamp'] = this.timpstamp;
    map['type'] = this.type;
    map['doctorType'] = this.doctorType;

    return map;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['senderId'] = this.senderId;
    data['receiverId'] = this.receiverId;
    data['senderName'] = this.senderName;
    data['reciverName'] = this.reciverName;
    data['senderImage'] = this.senderImage;
    data['timpstamp'] = this.timpstamp;
    data['type'] = this.type;
    data['doctorType'] = this.doctorType;
    return data;
  }
}
