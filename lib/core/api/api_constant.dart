enum AppState { initial, loading, loaded, empty, error }

/// ApiConstant is a class that contains all the constants used in the API calls
class ApiConstant {
  /// A constant variable that is used to store the base url of the API.
  static const baseUrl = 'https://rewardixrms.couponz.ws/mobile.asmx/';

  /// login api constants
  static const login = 'login';

  /// register api constants
  static const register = 'Register';

  ///check user Registerd or not
  static const checkUserRegister = 'CheckUserRegistered';

  /// login api constants
  static const forgotPin = 'UpdatePIN';

  /// claim gift list api constants
  static const claimGift = 'GetGiftList';

  /// redeem gift
  static const redeemGift = 'ClaimGift';

  /// coupon history api constants
  static const couponHistory = 'GetCouponHistory';

  /// get notification API constant
  static const getNotification = 'GetUsersNotification';

  /// get gift status API constant
  static const getGiftStatus = 'GetGiftStatus';

  /// update pin API constant
  static const updatePin = 'UpdatePIN';

  /// claim coupon API constant
  static const claimCoupon = 'RedeemCouponByCouponText';

  /// A constant variable that is used to store the endpoint of mobile setting of the API.
  static const mobileSetting = 'GetMobileSettings';

  
  /// A constant variable that is used to store the endpoint of collect gift of the API.
  static const collectGift = 'CollectGift';
  
}
