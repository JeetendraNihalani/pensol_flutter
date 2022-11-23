import '../../../../../../core/api/api_constant.dart';
import '../../../../../../app/modules/auth/login/domain/login_domain.dart';
import '../../../../../../core/api/api_client.dart';
import '../../../../../../core/api/injector.dart';

/// > This class is a service that implements the LoginRepository interface
class LoginService implements LoginRepository {
  ApiClient loginRepo = getIt.get<ApiClient>();

 /// A method override.
  @override
  Future login(
    String? mobileNumber,
    String? password,
    String? deviceMake,
    String? deviceName,
    String? deviceToken,
  ) async {
    Map<String, String>? request = {
      "mobileNumber": mobileNumber ?? '',
      "pin": password ?? '',
      "device_make": deviceMake ?? '',
      "device_name": deviceName ?? '',
      "device_token": deviceToken ?? '',
    };
    final response = await loginRepo.restApiCall(
      endpoint: ApiConstant.login,
      method: ApiMethod.post,
      params: request,
    );
    return response;
  }
}
