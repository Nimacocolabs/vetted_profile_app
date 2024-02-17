class RegisterResponse {
  bool? success;
  int? status;
  String? message;
  int? collegeId;
  String? qrCode;

  RegisterResponse(
      {this.success, this.status, this.message, this.collegeId, this.qrCode});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    collegeId = json['college_id'];
    qrCode = json['qr_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    data['message'] = this.message;
    data['college_id'] = this.collegeId;
    data['qr_code'] = this.qrCode;
    return data;
  }
}