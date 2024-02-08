class ComplaintUpdateResponse {
  bool? success;
  int? statusCode;
  String? message;
  Profile? profile;

  ComplaintUpdateResponse(
      {this.success, this.statusCode, this.message, this.profile});

  ComplaintUpdateResponse.fromJson(Map<String, dynamic> json) {
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
  String? pan;
  String? subject;
  String? address;
  String? department;
  String? complaint;
  String? level;
  String? image;
  Null? claim;
  String? remarks;
  String? status;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

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
        this.remarks,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

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
    remarks = json['remarks'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
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
    data['remarks'] = this.remarks;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}