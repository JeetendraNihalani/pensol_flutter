import '../../../../../app/modules/auth/login/domain/models/auth_model.dart';
import '../../../../../core/api/api_constant.dart';
import '../../../../../core/services/auth_service.dart';
import '../../../../../app/modules/home/domain/repository/home_repository.dart';
import '../../../../../core/api/api_client.dart';
import '../../../../../core/api/injector.dart';

/// > This class is a service that implements the HomeRepository interface
class HomeService implements HomeRepository {
  /// Injecting the ApiClient class into the HomeService class.
  final _homeRepo = getIt.get<ApiClient>();

  @override
  /// Calling the `restApiCall()` method of the `ApiClient` class.
  Future getMobileSetting() async {
    AuthModel userDetails = await AuthService().userDetails();

    final userId = userDetails.result?[0].iUserId;

    Map<String, String>? request = {
      "userId": userId.toString(),
    };
    final response = await _homeRepo.restApiCall(
      endpoint: ApiConstant.mobileSetting,
      method: ApiMethod.post,
      params: request,
    );
    return response;
  }
}
