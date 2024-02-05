class CommonResponse {
  int? statusCode;
  bool? success;
  String? message;

  CommonResponse({this.statusCode, this.success, this.message});

  CommonResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json["success"];
    message = json['message'];
  }
}
