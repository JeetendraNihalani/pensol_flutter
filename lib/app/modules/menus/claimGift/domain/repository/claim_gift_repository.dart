import '../claim_gift_domain.dart';

/// This class is an abstract class that defines the methods that will be used to interact with the
/// database
abstract class ClaimGiftRepository {
  factory ClaimGiftRepository() => ClaimGiftService();

  Future getClaimGiftList();

  Future redeemGift(String giftId,String userId,String qty);
}

