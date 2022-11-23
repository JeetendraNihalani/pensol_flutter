



import '../gift_status_domain.dart';

abstract class GiftStatusRepository {

  factory GiftStatusRepository() => GiftStatusService();

  
  Future getGiftStatus();
}