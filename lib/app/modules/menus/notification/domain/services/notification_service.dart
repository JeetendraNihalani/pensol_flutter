import 'package:pensol/app/modules/auth/login/domain/models/auth_model.dart';
import 'package:pensol/core/api/api_constant.dart';
import 'package:pensol/core/services/auth_service.dart';

import '../../../../../../app/modules/menus/notification/domain/notification_domain.dart';
import '../../../../../../core/api/api_client.dart';
import '../../../../../../core/api/injector.dart';

class NotificationService implements NotificationRepository {
  final _repo = getIt.get<ApiClient>();

  @override
  Future getNotification() async {
    AuthModel userDetails = await AuthService().userDetails();

    final userId = userDetails.result?[0].iUserId.toString();
    final accessToken = userDetails.result?[0].accessToken;

    Map<String, String>? request = {
      "userId": userId ?? '',
    };
    final response = await _repo.restApiCall(
      endpoint: ApiConstant.getNotification,
      method: ApiMethod.post,
      params: request,
      mHeader: {'access_token': accessToken, 'user_id': userId},
    );
    return response;
  }
}
