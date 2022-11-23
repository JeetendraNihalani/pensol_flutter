



import 'package:image_picker/image_picker.dart';

import '../gift_collection_domain.dart';

abstract class GiftCollectionRepository {

  factory GiftCollectionRepository() => GiftCollectionService();

  
  /// A function that returns a Future.
  Future getGiftCollection();


  Future /// A function that returns a Future.
  collectGift(String? giftId,XFile? image);
}