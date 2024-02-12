class ScheduledListResponse {
  bool? success;
  String? message;
  List<Hearings>? hearings;
  Pages? pages;

  ScheduledListResponse(
      {this.success, this.message, this.hearings, this.pages});

  ScheduledListResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['hearings'] != null) {
      hearings = <Hearings>[];
      json['hearings'].forEach((v) {
        hearings!.add(new Hearings.fromJson(v));
      });
    }
    pages = json['pages'] != null ? new Pages.fromJson(json['pages']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.hearings != null) {
      data['hearings'] = this.hearings!.map((v) => v.toJson()).toList();
    }
    if (this.pages != null) {
      data['pages'] = this.pages!.toJson();
    }
    return data;
  }
}

class Hearings {
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
  String? scheduledDate;
  String? scheduledTime;
  String? hearingStatus;
  String? meetingLink;

  Hearings(
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
        this.state,
        this.scheduledDate,
        this.scheduledTime,
        this.hearingStatus,
        this.meetingLink});

  Hearings.fromJson(Map<String, dynamic> json) {
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
    scheduledDate = json['scheduled_date'];
    scheduledTime = json['scheduled_time'];
    hearingStatus = json['hearing_status'];
    meetingLink = json['meeting_link'];
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
    data['scheduled_date'] = this.scheduledDate;
    data['scheduled_time'] = this.scheduledTime;
    data['hearing_status'] = this.hearingStatus;
    data['meeting_link'] = this.meetingLink;
    return data;
  }
}

class Pages {
  int? total;
  String? page;
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