



import '../coupon_history_domain.dart';

/// This class is an abstract class that defines the methods that will be used to interact with the
/// database
abstract class CouponHistoryRepository {

  factory CouponHistoryRepository() => CouponHistoryService();

  
  Future getCouponHistory();
}