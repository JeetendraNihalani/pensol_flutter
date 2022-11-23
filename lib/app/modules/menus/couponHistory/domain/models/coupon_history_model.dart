/// This class is a model for the CouponHistory table in the database.
class CouponHistoryModel {
  int? statusCode;
  String? message;
  List<CouponHistoryResult>? couponHistoryResult;
  bool? isSuccess;

  CouponHistoryModel(
      {this.statusCode, this.message, this.couponHistoryResult, this.isSuccess});

  CouponHistoryModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['StatusCode'];
    message = json['Message'];
    if (json['Result'] != null) {
      couponHistoryResult = <CouponHistoryResult>[];
      json['Result'].forEach((v) {
        couponHistoryResult!.add( CouponHistoryResult.fromJson(v));
      });
    }
    isSuccess = json['IsSuccess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['StatusCode'] = statusCode;
    data['Message'] = message;
    if (couponHistoryResult != null) {
      data['Result'] = couponHistoryResult!.map((v) => v.toJson()).toList();
    }
    data['IsSuccess'] = isSuccess;
    return data;
  }
}

class CouponHistoryResult {
  double? nCouponHistoryID;
  int? redeemedPoint;
  String? vSINo;
  String? productCode;
  String? dModifiedOn;

  CouponHistoryResult(
      {this.nCouponHistoryID,
      this.redeemedPoint,
      this.vSINo,
      this.productCode,
      this.dModifiedOn});

  CouponHistoryResult.fromJson(Map<String, dynamic> json) {
    nCouponHistoryID = json['nCouponHistoryID'];
    redeemedPoint = json['RedeemedPoint'];
    vSINo = json['vSINo'];
    productCode = json['ProductCode'];
    dModifiedOn = json['dModifiedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['nCouponHistoryID'] = nCouponHistoryID;
    data['RedeemedPoint'] = redeemedPoint;
    data['vSINo'] = vSINo;
    data['ProductCode'] = productCode;
    data['dModifiedOn'] = dModifiedOn;
    return data;
  }
}
