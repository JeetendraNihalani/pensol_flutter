



import '../update_pin_domain.dart';

abstract class UpdatePinRepository {

  factory UpdatePinRepository() => UpdatePinService();

  
  Future updatePin(String? newPin, String? confirmPin,var userId);
}