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