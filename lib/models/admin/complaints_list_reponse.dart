class ComplaintsListResponse {
  bool? success;
  String? message;
  List<Profiles>? profiles;
  Pages? pages;

  ComplaintsListResponse(
      {this.success, this.message, this.profiles, this.pages});

  ComplaintsListResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['profiles'] != null) {
      profiles = <Profiles>[];
      json['profiles'].forEach((v) {
        profiles!.add(new Profiles.fromJson(v));
      });
    }
    pages = json['pages'] != null ?  Pages.fromJson(json['pages']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.profiles != null) {
      data['profiles'] = this.profiles!.map((v) => v.toJson()).toList();
    }
    if (this.pages != null) {
      data['pages'] = this.pages!.toJson();
    }
    return data;
  }
}

class Profiles {
  int? id;
  int? collegeId;
  String? collegeName;
  String? image;
  String? name;
  String? email;
  String? phone;
  String? aadhar;
  String? pan;
  String? subject;
  String? department;
  String? address;
  String? complaint;
  String? claim;
  String? level;
  String? remarks;
  String? status;
  String? collegeEmail;
  String? collegePhone;
  String? code;
  String? collegeAddress;
  String? date;
  String? city;
  String? state;

  Profiles(
      {this.id,
        this.collegeId,
        this.collegeName,
        this.image,
        this.name,
        this.email,
        this.phone,
        this.aadhar,
        this.pan,
        this.subject,
        this.department,
        this.address,
        this.complaint,
        this.claim,
        this.level,
        this.remarks,
        this.status,
        this.collegeEmail,
        this.collegePhone,
        this.code,
        this.collegeAddress,
        this.date,
        this.city,
        this.state});

  Profiles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    collegeId = json['college_id'];
    collegeName = json['college_name'];
    image = json['image'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    aadhar = json['aadhar'];
    pan = json['pan'];
    subject = json['subject'];
    department = json['department'];
    address = json['address'];
    complaint = json['complaint'];
    claim = json['claim'];
    level = json['level'];
    remarks = json['remarks'];
    status = json['status'];
    collegeEmail = json['college_email'];
    collegePhone = json['college_phone'];
    code = json['code'];
    collegeAddress = json['college_address'];
    date = json['date'];
    city = json['city'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['college_id'] = this.collegeId;
    data['college_name'] = this.collegeName;
    data['image'] = this.image;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['aadhar'] = this.aadhar;
    data['pan'] = this.pan;
    data['subject'] = this.subject;
    data['department'] = this.department;
    data['address'] = this.address;
    data['complaint'] = this.complaint;
    data['claim'] = this.claim;
    data['level'] = this.level;
    data['remarks'] = this.remarks;
    data['status'] = this.status;
    data['college_email'] = this.collegeEmail;
    data['college_phone'] = this.collegePhone;
    data['code'] = this.code;
    data['college_address'] = this.collegeAddress;
    data['date'] = this.date;
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