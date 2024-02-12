class ScheduledDetailsResponse {
  bool? success;
  int? statusCode;
  String? message;
  Profile? profile;

  ScheduledDetailsResponse(
      {this.success, this.statusCode, this.message, this.profile});

  ScheduledDetailsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    message = json['message'];
    profile =
    json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    return data;
  }
}

class Profile {
  int? id;
  int? collegeId;
  String? name;
  String? email;
  String? phone;
  String? aadhar;
  Null? pan;
  String? subject;
  String? address;
  String? department;
  String? complaint;
  String? level;
  String? image;
  String? claim;
  String? claimedAt;
  String? remarks;
  String? status;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  String? scheduledDate;
  String? scheduledTime;
  String? hearingStatus;
  String? meetingLink;
  College? college;

  Profile(
      {this.id,
        this.collegeId,
        this.name,
        this.email,
        this.phone,
        this.aadhar,
        this.pan,
        this.subject,
        this.address,
        this.department,
        this.complaint,
        this.level,
        this.image,
        this.claim,
        this.claimedAt,
        this.remarks,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.scheduledDate,
        this.scheduledTime,
        this.hearingStatus,
        this.meetingLink,
        this.college});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    collegeId = json['college_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    aadhar = json['aadhar'];
    pan = json['pan'];
    subject = json['subject'];
    address = json['address'];
    department = json['department'];
    complaint = json['complaint'];
    level = json['level'];
    image = json['image'];
    claim = json['claim'];
    claimedAt = json['claimed_at'];
    remarks = json['remarks'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    scheduledDate = json['scheduled_date'];
    scheduledTime = json['scheduled_time'];
    hearingStatus = json['hearing_status'];
    meetingLink = json['meeting_link'];
    college =
    json['college'] != null ? new College.fromJson(json['college']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['college_id'] = this.collegeId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['aadhar'] = this.aadhar;
    data['pan'] = this.pan;
    data['subject'] = this.subject;
    data['address'] = this.address;
    data['department'] = this.department;
    data['complaint'] = this.complaint;
    data['level'] = this.level;
    data['image'] = this.image;
    data['claim'] = this.claim;
    data['claimed_at'] = this.claimedAt;
    data['remarks'] = this.remarks;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['scheduled_date'] = this.scheduledDate;
    data['scheduled_time'] = this.scheduledTime;
    data['hearing_status'] = this.hearingStatus;
    data['meeting_link'] = this.meetingLink;
    if (this.college != null) {
      data['college'] = this.college!.toJson();
    }
    return data;
  }
}

class College {
  int? id;
  int? userId;
  String? collegeName;
  String? code;
  String? collegeEmail;
  String? collegePhone;
  String? address;
  String? city;
  String? state;
  String? status;
  String? createdAt;
  String? updatedAt;

  College(
      {this.id,
        this.userId,
        this.collegeName,
        this.code,
        this.collegeEmail,
        this.collegePhone,
        this.address,
        this.city,
        this.state,
        this.status,
        this.createdAt,
        this.updatedAt});

  College.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    collegeName = json['college_name'];
    code = json['code'];
    collegeEmail = json['college_email'];
    collegePhone = json['college_phone'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['college_name'] = this.collegeName;
    data['code'] = this.code;
    data['college_email'] = this.collegeEmail;
    data['college_phone'] = this.collegePhone;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}