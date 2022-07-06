class CreateQuestionRequest {
  String? question;

  CreateQuestionRequest({this.question});

  CreateQuestionRequest.fromJson(Map<String, dynamic> json) {
    question = json['question'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    return data;
  }
}
