



import '../manual_coupon_code_domain.dart';

abstract class ManualCouponCodeRepository {

  factory ManualCouponCodeRepository() => ManualCouponCodeService();

  
  Future redeemCoupon(String? couponCode);
}