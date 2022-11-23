/// A model class for the authentication.
class AuthModel {
  int? statusCode;
  String? message;
  List<AuthResult>? result;
  bool? isSuccess;

  AuthModel({this.statusCode, this.message, this.result, this.isSuccess});

  AuthModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['StatusCode'];
    message = json['Message'];
    if (json['Result'] != null) {
      result = <AuthResult>[];
      json['Result'].forEach((v) {
        result!.add(AuthResult.fromJson(v));
      });
    }
    isSuccess = json['IsSuccess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['StatusCode'] = statusCode;
    data['Message'] = message;
    if (result != null) {
      data['Result'] = result!.map((v) => v.toJson()).toList();
    }
    data['IsSuccess'] = isSuccess;
    return data;
  }
}

class AuthResult {
  int? iUserId;
  int? iUserTypeId;
  String? vFirstName;
  String? vLastName;
  String? vLoginName;
  String? vEmailId;
  String? iMobileNo;
  String? vAddress;
  String? vTimeZone;
  String? vThemeName;
  String? iDepotId;
  String? shopName;
  int? vAvailablePoints;
  String? pincode;
  String? city;
  String? state;
  String? aadharNo;
  String? dsrName;
  String? pensolSalesPersonName;
  String? roadName;
  int? vNearestGiftPoint;
  String? vNearestGiftName;
  String? vIsUpdatedPin;
  String? profilePic;
  int? passwordCount;
  String? isZoneManager;
  String? isMechanic;
  String? accessToken;

  AuthResult(
      {this.iUserId,
      this.iUserTypeId,
      this.vFirstName,
      this.vLastName,
      this.vLoginName,
      this.vEmailId,
      this.iMobileNo,
      this.vAddress,
      this.vTimeZone,
      this.vThemeName,
      this.iDepotId,
      this.shopName,
      this.vAvailablePoints,
      this.pincode,
      this.city,
      this.state,
      this.aadharNo,
      this.dsrName,
      this.pensolSalesPersonName,
      this.roadName,
      this.vNearestGiftPoint,
      this.vNearestGiftName,
      this.vIsUpdatedPin,
      this.profilePic,
      this.passwordCount,
      this.isZoneManager,
      this.isMechanic,
      this.accessToken});

  AuthResult.fromJson(Map<String, dynamic> json) {
    iUserId = json['iUserId'];
    iUserTypeId = json['iUserTypeId'];
    vFirstName = json['vFirstName'];
    vLastName = json['vLastName'];
    vLoginName = json['vLoginName'];
    vEmailId = json['vEmailId'];
    iMobileNo = json['iMobileNo'];
    vAddress = json['vAddress'];
    vTimeZone = json['vTimeZone'];
    vThemeName = json['vThemeName'];
    iDepotId = json['iDepotId'];
    shopName = json['shop_name'];
    vAvailablePoints = json['vAvailablePoints'];
    pincode = json['pincode'];
    city = json['city'];
    state = json['state'];
    aadharNo = json['aadhar_no'];
    dsrName = json['dsr_name'];
    pensolSalesPersonName = json['pensol_sales_person_name'];
    roadName = json['road_name'];
    vNearestGiftPoint = json['vNearestGiftPoint'];
    vNearestGiftName = json['vNearestGiftName'];
    vIsUpdatedPin = json['vIsUpdatedPin'];
    profilePic = json['profile_pic'];
    passwordCount = json['PasswordCount'];
    isZoneManager = json['IsZoneManager'];
    isMechanic = json['IsMechanic'];
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['iUserId'] = iUserId;
    data['iUserTypeId'] = iUserTypeId;
    data['vFirstName'] = vFirstName;
    data['vLastName'] = vLastName;
    data['vLoginName'] = vLoginName;
    data['vEmailId'] = vEmailId;
    data['iMobileNo'] = iMobileNo;
    data['vAddress'] = vAddress;
    data['vTimeZone'] = vTimeZone;
    data['vThemeName'] = vThemeName;
    data['iDepotId'] = iDepotId;
    data['shop_name'] = shopName;
    data['vAvailablePoints'] = vAvailablePoints;
    data['pincode'] = pincode;
    data['city'] = city;
    data['state'] = state;
    data['aadhar_no'] = aadharNo;
    data['dsr_name'] = dsrName;
    data['pensol_sales_person_name'] = pensolSalesPersonName;
    data['road_name'] = roadName;
    data['vNearestGiftPoint'] = vNearestGiftPoint;
    data['vNearestGiftName'] = vNearestGiftName;
    data['vIsUpdatedPin'] = vIsUpdatedPin;
    data['profile_pic'] = profilePic;
    data['PasswordCount'] = passwordCount;
    data['IsZoneManager'] = isZoneManager;
    data['IsMechanic'] = isMechanic;
    data['access_token'] = accessToken;
    return data;
  }
}
