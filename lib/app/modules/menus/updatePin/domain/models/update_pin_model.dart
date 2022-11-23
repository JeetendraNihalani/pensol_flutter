class UpdatePinModel {
  int? statusCode;
  String? message;
  List<Result>? result;
  bool? isSuccess;

  UpdatePinModel({this.statusCode, this.message, this.result, this.isSuccess});

  UpdatePinModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['StatusCode'];
    message = json['Message'];
    if (json['Result'] != null) {
      result = <Result>[];
      json['Result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
    isSuccess = json['IsSuccess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['StatusCode'] = statusCode;
    data['Message'] = message;
    if (result != null) {
      data['Result'] = result!.map((v) => v.toJson()).toList();
    }
    data['IsSuccess'] = isSuccess;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['iUserId'] = iUserId;
    return data;
  }
}
