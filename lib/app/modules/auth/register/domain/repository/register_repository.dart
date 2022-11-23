import '../services/register_service.dart';

/// It's an abstract class that has a  method called login
abstract class RegisterRepository {
  factory RegisterRepository() => RegisterService();

  Future register(String name,String workshopName,String roadName,String pincode,String city,String state,String mobileNumber,String aadharNumber,String distributorName,String pensolSalePersonName,String image,String token,String newPin);
}
