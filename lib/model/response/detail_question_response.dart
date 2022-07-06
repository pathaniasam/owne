class DetailQuestionResponse {
  List<DetailQuestionData>? data;
  PageInfo? pageInfo;

  DetailQuestionResponse({this.data, this.pageInfo});

  DetailQuestionResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DetailQuestionData>[];
      json['data'].forEach((v) {
        data!.add(new DetailQuestionData.fromJson(v));
      });
    }
    pageInfo = json['page_info'] != null
        ? new PageInfo.fromJson(json['page_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.pageInfo != null) {
      data['page_info'] = this.pageInfo!.toJson();
    }
    return data;
  }
}

class DetailQuestionData {
  int? id;
  String? answer;
  String? createdAt;
  User? user;

  DetailQuestionData({this.id, this.answer, this.createdAt, this.user});

  DetailQuestionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    answer = json['answer'];
    createdAt = json['createdAt'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['answer'] = this.answer;
    data['createdAt'] = this.createdAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? name;
  String? profileImage;

  User({this.name,this.profileImage});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['profileImage'] = this.profileImage;
    return data;
  }
}

class PageInfo {
  String? nextPageUrl;
  String? prevPageUrl;
  int? totalCount;
  bool? hasMoreData;

  PageInfo(
      {this.nextPageUrl, this.prevPageUrl, this.totalCount, this.hasMoreData});

  PageInfo.fromJson(Map<String, dynamic> json) {
    nextPageUrl = json['next_page_url'];
    prevPageUrl = json['prev_page_url'];
    totalCount = json['total_count'];
    hasMoreData = json['has_more_data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['next_page_url'] = this.nextPageUrl;
    data['prev_page_url'] = this.prevPageUrl;
    data['total_count'] = this.totalCount;
    data['has_more_data'] = this.hasMoreData;
    return data;
  }
}
