class LoginSignupResponse {
  bool? success;
  int? status;
  String? message;
  User? user;
  bool? otpRequired;
  int? userId;
  int? deviceId;
  String? token;
  Errors? errors;

  LoginSignupResponse(
      {this.success, this.status, this.message, this.user,this.token,this.errors,this.userId,this.otpRequired,this.deviceId});

  LoginSignupResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
    otpRequired = json['otp_required'];
    userId = json['user_id'];
    deviceId = json['device_id'];
    errors = json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    if (this.errors != null) {
      data['errors'] = this.errors!.toJson();
    }
    data['otp_required'] = this.otpRequired;
    data['user_id'] = this.userId;
    data['device_id'] = this.deviceId;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? phone2;
  String? role;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.phone2,
        this.role,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    phone2 = json['phone2'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['phone2'] = this.phone2;
    data['role'] = this.role;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}


class Errors {
  List<String>? email;

  Errors({this.email});

  Errors.fromJson(Map<String, dynamic> json) {
    email = json['email'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    return data;
  }
}