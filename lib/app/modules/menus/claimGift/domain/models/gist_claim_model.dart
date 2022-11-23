class GiftClaimModel {
  int? statusCode;
  String? message;
  List<Result>? result;
  bool? isSuccess;

  GiftClaimModel({this.statusCode, this.message, this.result, this.isSuccess});

  GiftClaimModel.fromJson(Map<String, dynamic> json) {
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
  int? vAvailablePoints;
  double? vNearestGiftPoint;
  String? vNearestGiftName;

  Result(
      {this.vAvailablePoints, this.vNearestGiftPoint, this.vNearestGiftName});

  Result.fromJson(Map<String, dynamic> json) {
    vAvailablePoints = json['vAvailablePoints'];
    vNearestGiftPoint = json['vNearestGiftPoint'];
    vNearestGiftName = json['vNearestGiftName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vAvailablePoints'] = this.vAvailablePoints;
    data['vNearestGiftPoint'] = this.vNearestGiftPoint;
    data['vNearestGiftName'] = this.vNearestGiftName;
    return data;
  }
}