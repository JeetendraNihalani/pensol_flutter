class CheckUserRegisterModel {
  int? statusCode;
  String? message;
  List<Result>? result;
  bool? isSuccess;

  CheckUserRegisterModel(
      {this.statusCode, this.message, this.result, this.isSuccess});

  CheckUserRegisterModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['StatusCode'];
    message = json['Message'];
    if (json['Result'] != null) {
      result = <Result>[];
      json['Result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
    isSuccess = json['IsSuccess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StatusCode'] = this.statusCode;
    data['Message'] = this.message;
    if (this.result != null) {
      data['Result'] = this.result!.map((v) => v.toJson()).toList();
    }
    data['IsSuccess'] = this.isSuccess;
    return data;
  }
}

class Result {
  var iUserId;

  Result({this.iUserId});

  Result.fromJson(Map<String, dynamic> json) {
    iUserId = json['iUserId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iUserId'] = this.iUserId;
    return data;
  }
}