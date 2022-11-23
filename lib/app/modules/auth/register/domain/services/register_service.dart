import '../../../../../../core/api/api_constant.dart';
import '../../../../../../app/modules/auth/login/domain/login_domain.dart';
import '../../../../../../core/api/api_client.dart';
import '../../../../../../core/api/injector.dart';
import '../repository/register_repository.dart';

/// > This class is a service that implements the LoginRepository interface
class RegisterService implements RegisterRepository {
  ApiClient registerRepo = getIt.get<ApiClient>();

  @override
  Future register(String name,String workshopName,String roadName,String pincode,String city,String state,String mobileNumber,String aadharNumber,String distributorName,String pensolSalePersonName,String image,String token,String newPin) async {
    Map<String, String>? request = {
      "shop_name": workshopName,
      "name_of_mechanic": name,
      "road_name": roadName,
      "pincode": pincode,
      "city": city,
      "state": state,
      "mobile_number": mobileNumber,
      "aadhaar_card_number": aadharNumber,
      "distributor_name": distributorName,
      "pensol_sales_person_name": pensolSalePersonName,
      "user_profile_pic": image,
      "fcm_token": token,
      "login_pin": newPin,
    };
    final response = await registerRepo.restApiCall(
      endpoint: ApiConstant.register,
      method: ApiMethod.post,
      params: request,
    );
    return response;
  }
}
