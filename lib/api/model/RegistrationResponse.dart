class RegistrationResponse {
  int? status;
  String? message;
  int? userId;

  RegistrationResponse({this.status, this.message, this.userId});

  RegistrationResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    userId = json['UserId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['UserId'] = this.userId;
    return data;
  }
}