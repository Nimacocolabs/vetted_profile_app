class ProfileResponse {
  bool? success;
  int? statusCode;
  String? message;
  User? user;

  ProfileResponse({this.success, this.statusCode, this.message, this.user});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? phone2;
  String? emailVerifiedAt;
  String? role;
  String? createdAt;
  String? updatedAt;
  String? image;
  String? status;
  String? imageUrl;

  User(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.phone2,
        this.emailVerifiedAt,
        this.role,
        this.createdAt,
        this.updatedAt,
        this.image,
        this.status,
        this.imageUrl});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    phone2 = json['phone2'];
    emailVerifiedAt = json['email_verified_at'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
    status = json['status'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['phone2'] = this.phone2;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['role'] = this.role;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image'] = this.image;
    data['status'] = this.status;
    data['image_url'] = this.imageUrl;
    return data;
  }
}