class CommitteeAddResponse {
  bool? success;
  int? statusCode;
  String? message;
  UserData? userData;

  CommitteeAddResponse(
      {this.success, this.statusCode, this.message, this.userData});

  CommitteeAddResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    message = json['message'];
    userData = json['userData'] != null
        ? new UserData.fromJson(json['userData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.userData != null) {
      data['userData'] = this.userData!.toJson();
    }
    return data;
  }
}

class UserData {
  String? name;
  String? email;
  String? phone;
  String? phone2;
  String? role;
  String? updatedAt;
  String? createdAt;
  int? id;

  UserData(
      {this.name,
        this.email,
        this.phone,
        this.phone2,
        this.role,
        this.updatedAt,
        this.createdAt,
        this.id});

  UserData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    phone2 = json['phone2'];
    role = json['role'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['phone2'] = this.phone2;
    data['role'] = this.role;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}