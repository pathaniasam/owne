  class ReviewRequest {
  int? stars;
  String? review;

  ReviewRequest({this.stars, this.review});

  ReviewRequest.fromJson(Map<String, dynamic> json) {
    stars = json['stars'];
    review = json['review'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stars'] = this.stars;
    data['review'] = this.review;
    return data;
  }
}
