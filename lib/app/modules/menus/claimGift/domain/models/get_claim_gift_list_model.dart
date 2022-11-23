///
class GetClaimGiftListModel {
  int? statusCode;
  String? message;
  List<ClaimGiftListResult>? claimGiftListResult;
  bool? isSuccess;

  GetClaimGiftListModel(
      {this.statusCode,
      this.message,
      this.claimGiftListResult,
      this.isSuccess});

  GetClaimGiftListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['StatusCode'];
    message = json['Message'];
    if (json['Result'] != null) {
      claimGiftListResult = <ClaimGiftListResult>[];
      json['Result'].forEach((v) {
        claimGiftListResult!.add(ClaimGiftListResult.fromJson(v));
      });
    }
    isSuccess = json['IsSuccess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['StatusCode'] = statusCode;
    data['Message'] = message;
    if (claimGiftListResult != null) {
      data['Result'] = claimGiftListResult!.map((v) => v.toJson()).toList();
    }
    data['IsSuccess'] = isSuccess;
    return data;
  }
}

class ClaimGiftListResult {
  int? iUserGiftProcessId;
  double? giftId;
  String? giftName;
  int giftQty = 1;
  String? giftImageUrl;
  double? redeemablePoints;
  double? mechanicTypeId;
  String? giftDetails;
  String? startDate;
  String? endDate;
  String? isGiftCollected;
  String? claimStatus;
  String? giftCollectionImage;
  String? claimGiftDate;
  String? collectGiftDate;

  ClaimGiftListResult(
      {this.iUserGiftProcessId,
      this.giftId,
      this.giftName,
      this.giftQty = 1,
      this.giftImageUrl,
      this.redeemablePoints,
      this.mechanicTypeId,
      this.giftDetails,
      this.startDate,
      this.endDate,
      this.isGiftCollected,
      this.claimStatus,
      this.giftCollectionImage,
      this.claimGiftDate,
      this.collectGiftDate});

  ClaimGiftListResult.fromJson(Map<String, dynamic> json) {
    iUserGiftProcessId = json['iUserGiftProcessId'];
    giftId = json['GiftId'];
    giftName = json['GiftName'];
    // giftQty = json['giftQty'];
    giftImageUrl = json['GiftImageUrl'];
    redeemablePoints = json['RedeemablePoints'];
    mechanicTypeId = json['MechanicTypeId'];
    giftDetails = json['GiftDetails'];
    startDate = json['StartDate'];
    endDate = json['EndDate'];
    isGiftCollected = json['isGiftCollected'];
    claimStatus = json['claimStatus'];
    giftCollectionImage = json['giftCollectionImage'];
    claimGiftDate = json['claimGiftDate'];
    collectGiftDate = json['collectGiftDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['iUserGiftProcessId'] = iUserGiftProcessId;
    data['GiftId'] = giftId;
    data['GiftName'] = giftName;
    data['giftQty'] = giftQty;
    data['GiftImageUrl'] = giftImageUrl;
    data['RedeemablePoints'] = redeemablePoints;
    data['MechanicTypeId'] = mechanicTypeId;
    data['GiftDetails'] = giftDetails;
    data['StartDate'] = startDate;
    data['EndDate'] = endDate;
    data['isGiftCollected'] = isGiftCollected;
    data['claimStatus'] = claimStatus;
    data['giftCollectionImage'] = giftCollectionImage;
    data['claimGiftDate'] = claimGiftDate;
    data['collectGiftDate'] = collectGiftDate;
    return data;
  }
}
