import '../../../../../../core/api/api_constant.dart';
import '../../../../../../app/modules/auth/login/domain/login_domain.dart';
import '../../../../../../core/api/api_client.dart';
import '../../../../../../core/api/injector.dart';
import '../repository/forgotPin_repository.dart';

/// > This class is a service that implements the LoginRepository interface
class ForgotPinService implements ForgotPinRepository {
  ApiClient forgotPinRepo = getIt.get<ApiClient>();

  @override
  Future checkUserRegister(
      String? MobileNo,
      ) async {
    Map<String, String>? request = {
      "MobileNo": MobileNo ?? '',
    };
    final response = await forgotPinRepo.restApiCall(
      endpoint: ApiConstant.checkUserRegister,
      method: ApiMethod.post,
      params: request,
    );
    return response;
  }
}
