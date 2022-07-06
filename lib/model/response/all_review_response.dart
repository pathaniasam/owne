class AllReviewResponse {
  List<AllReviewData>? data;

  AllReviewResponse({this.data});

  AllReviewResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <AllReviewData>[];
      json['data'].forEach((v) {
        data!.add(new AllReviewData.fromJson(v));
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

class AllReviewData {
  int? id;
  int? userId;
  int? professionalId;
  int? appointmentId;
  int? star;
  String? review;
  String? createdAt;

  AllReviewData(
      {this.id,
        this.userId,
        this.professionalId,
        this.appointmentId,
        this.star,
        this.review,
        this.createdAt});

  AllReviewData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    professionalId = json['professionalId'];
    appointmentId = json['appointmentId'];
    star = json['star'];
    review = json['review'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['professionalId'] = this.professionalId;
    data['appointmentId'] = this.appointmentId;
    data['star'] = this.star;
    data['review'] = this.review;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
