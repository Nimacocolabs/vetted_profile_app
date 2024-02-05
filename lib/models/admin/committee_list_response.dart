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

  Committee({this.id, this.name, this.email, this.phone, this.phone2});

  Committee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    phone2 = json['phone2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['phone2'] = this.phone2;
    return data;
  }
}

class Pages {
  int? total;
  String? currentPage;
  String? nextPage;
  String? prevPage;
  String? firstPage;
  String? lastPage;
  Pages? pages;

  Pages(
      {this.total,
        this.currentPage,
        this.nextPage,
        this.prevPage,
        this.firstPage,
        this.lastPage,
        this.pages});

  Pages.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    currentPage = json['current_page'];
    nextPage = json['next_page'];
    prevPage = json['prev_page'];
    firstPage = json['first_page'];
    lastPage = json['last_page'];
    pages = json['pages'] != null ? new Pages.fromJson(json['pages']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['current_page'] = this.currentPage;
    data['next_page'] = this.nextPage;
    data['prev_page'] = this.prevPage;
    data['first_page'] = this.firstPage;
    data['last_page'] = this.lastPage;
    if (this.pages != null) {
      data['pages'] = this.pages!.toJson();
    }
    return data;
  }
}

class Pages1 {
  String? s1;

  Pages1({this.s1});

  Pages1.fromJson(Map<String, dynamic> json) {
    s1 = json['1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1'] = this.s1;
    return data;
  }
}