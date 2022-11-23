class RegisterModel {
  int? statusCode;
  String? message;
  Null? result;
  bool? isSuccess;

  RegisterModel({this.statusCode, this.message, this.result, this.isSuccess});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['StatusCode'];
    message = json['Message'];
    result = json['Result'];
    isSuccess = json['IsSuccess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StatusCode'] = this.statusCode;
    data['Message'] = this.message;
    data['Result'] = this.result;
    data['IsSuccess'] = this.isSuccess;
    return data;
  }
}