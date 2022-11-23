import '../services/forgotPin_service.dart';

/// It's an abstract class that has a  method called login
abstract class ForgotPinRepository {
  factory ForgotPinRepository() => ForgotPinService();

  Future checkUserRegister(
      String? MobileNo,
      );
}
