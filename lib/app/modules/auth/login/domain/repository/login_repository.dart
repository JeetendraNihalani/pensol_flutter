import '../login_domain.dart';

/// It's an abstract class that has a  method called login
abstract class LoginRepository {
  factory LoginRepository() => LoginService();

  Future login(
    String? mobileNumber,
    String? password,
    String? deviceMake,
    String? deviceName,
    String? deviceToken,
  );
}
