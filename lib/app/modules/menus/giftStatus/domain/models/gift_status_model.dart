class GiftStatusModel {
  int? statusCode;
  String? message;
  List<GiftStatusResult>? giftStatusResult;
  bool? isSuccess;

  GiftStatusModel({this.statusCode, this.message, this.giftStatusResult, this.isSuccess});

  GiftStatusModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['StatusCode'];
    message = json['Message'];
    if (json['Result'] != null) {
      giftStatusResult = <GiftStatusResult>[];
      json['Result'].forEach((v) {
        giftStatusResult!.add( GiftStatusResult.fromJson(v));
      });
    }
    isSuccess = json['IsSuccess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['StatusCode'] = statusCode;
    data['Message'] = message;
    if (giftStatusResult != null) {
      data['Result'] = giftStatusResult!.map((v) => v.toJson()).toList();
    }
    data['IsSuccess'] = isSuccess;
    return data;
  }
}

class GiftStatusResult {
  String? claimDate;
  int? iUserGiftProcessId;
  int? giftId;
  String? giftName;
  int? giftPoint;
  int? giftQty;
  int? iUserId;
  String? claimStatus;
  String? giftImageUrl;

  GiftStatusResult(
      {this.claimDate,
      this.iUserGiftProcessId,
      this.giftId,
      this.giftName,
      this.giftPoint,
      this.giftQty,
      this.iUserId,
      this.claimStatus,
      this.giftImageUrl});

  GiftStatusResult.fromJson(Map<String, dynamic> json) {
    claimDate = json['claimDate'];
    iUserGiftProcessId = json['iUserGiftProcessId'];
    giftId = json['giftId'];
    giftName = json['GiftName'];
    giftPoint = json['giftPoint'];
    giftQty = json['giftQty'];
    iUserId = json['iUserId'];
    claimStatus = json['claimStatus'];
    giftImageUrl = json['GiftImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['claimDate'] = claimDate;
    data['iUserGiftProcessId'] = iUserGiftProcessId;
    data['giftId'] = giftId;
    data['GiftName'] = giftName;
    data['giftPoint'] = giftPoint;
    data['giftQty'] = giftQty;
    data['iUserId'] = iUserId;
    data['claimStatus'] = claimStatus;
    data['GiftImageUrl'] = giftImageUrl;
    return data;
  }
}
