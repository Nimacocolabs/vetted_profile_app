class CommitteeListResponse {
  bool? success;
  String? message;
  List<Committee>? committee;
  Pages? pages;

  CommitteeListResponse(
      {this.success, this.message, this.committee, this.pages});

  CommitteeListResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['committee'] != null) {
      committee = <Committee>[];
      json['committee'].forEach((v) {
        committee!.add(new Committee.fromJson(v));
      });
    }
    pages = json['pages'] != null ? new Pages.fromJson(json['pages']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.committee != null) {
      data['committee'] = this.committee!.map((v) => v.toJson()).toList();
    }
    if (this.pages != null) {
      data['pages'] = this.pages!.toJson();
    }
    return data;
  }
}

class Committee {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? phone2;
  String? image;
  String? imageUrl;

  Committee(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.phone2,
        this.image,
        this.imageUrl});

  Committee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    phone2 = json['phone2'];
    image = json['image'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['phone2'] = this.phone2;
    data['image'] = this.image;
    data['image_url'] = this.imageUrl;
    return data;
  }
}

class Pages {
  int? total;
  int? page;
  int? lastPage;

  Pages({this.total, this.page, this.lastPage});

  Pages.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    page = json['page'];
    lastPage = json['last_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['page'] = this.page;
    data['last_page'] = this.lastPage;
    return data;
  }
}