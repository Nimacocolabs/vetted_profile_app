class CollegeListResponse {
  bool? success;
  String? message;
  List<Colleges>? colleges;
  Pages? pages;

  CollegeListResponse({this.success, this.message, this.colleges, this.pages});

  CollegeListResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['colleges'] != null) {
      colleges = <Colleges>[];
      json['colleges'].forEach((v) {
        colleges!.add(new Colleges.fromJson(v));
      });
    }
    pages = json['pages'] != null ? new Pages.fromJson(json['pages']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.colleges != null) {
      data['colleges'] = this.colleges!.map((v) => v.toJson()).toList();
    }
    if (this.pages != null) {
      data['pages'] = this.pages!.toJson();
    }
    return data;
  }
}

class Colleges {
  int? id;
  String? userName;
  String? collegeName;
  String? collegeEmail;
  String? code;
  String? collegePhone;
  String? status;
  String? address;
  String? city;
  String? state;

  Colleges(
      {this.id,
        this.userName,
        this.collegeName,
        this.collegeEmail,
        this.code,
        this.collegePhone,
        this.status,
        this.address,
        this.city,
        this.state});

  Colleges.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    collegeName = json['college_name'];
    collegeEmail = json['college_email'];
    code = json['code'];
    collegePhone = json['college_phone'];
    status = json['status'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_name'] = this.userName;
    data['college_name'] = this.collegeName;
    data['college_email'] = this.collegeEmail;
    data['code'] = this.code;
    data['college_phone'] = this.collegePhone;
    data['status'] = this.status;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
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
  String? s2;
  String? s3;

  Pages1({this.s1, this.s2, this.s3});

  Pages1.fromJson(Map<String, dynamic> json) {
    s1 = json['1'];
    s2 = json['2'];
    s3 = json['3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1'] = this.s1;
    data['2'] = this.s2;
    data['3'] = this.s3;
    return data;
  }
}