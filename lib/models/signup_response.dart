class LoginSignupResponse {
  bool? success;
  int? status;
  String? message;
  User? user;
  Details? details;
  String? token;
  Errors? errors;

  LoginSignupResponse(
      {this.success, this.status, this.message, this.user, this.details,this.token,this.errors});

  LoginSignupResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    details =
    json['details'] != null ? new Details.fromJson(json['details']) : null;
    token = json['token'];
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
    if (this.details != null) {
      data['details'] = this.details!.toJson();
    }
    data['token'] = this.token;
    if (this.errors != null) {
      data['errors'] = this.errors!.toJson();
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

class Details {
  Colleges? colleges;
  Profiles? profiles;
  int? committee;

  Details({this.colleges, this.profiles, this.committee});

  Details.fromJson(Map<String, dynamic> json) {
    colleges = json['colleges'] != null
        ? new Colleges.fromJson(json['colleges'])
        : null;
    profiles = json['profiles'] != null
        ? new Profiles.fromJson(json['profiles'])
        : null;
    committee = json['committee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.colleges != null) {
      data['colleges'] = this.colleges!.toJson();
    }
    if (this.profiles != null) {
      data['profiles'] = this.profiles!.toJson();
    }
    data['committee'] = this.committee;
    return data;
  }
}

class Colleges {
  int? pending;
  int? approved;

  Colleges({this.pending, this.approved});

  Colleges.fromJson(Map<String, dynamic> json) {
    pending = json['pending'];
    approved = json['approved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pending'] = this.pending;
    data['approved'] = this.approved;
    return data;
  }
}

class Profiles {
  int? claimed;
  int? registered;
  int? resolved;

  Profiles({this.claimed, this.registered, this.resolved});

  Profiles.fromJson(Map<String, dynamic> json) {
    claimed = json['claimed'];
    registered = json['registered'];
    resolved = json['resolved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['claimed'] = this.claimed;
    data['registered'] = this.registered;
    data['resolved'] = this.resolved;
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