import 'package:pensol/app/modules/auth/login/domain/models/auth_model.dart';
import 'package:pensol/core/api/api_constant.dart';
import 'package:pensol/core/services/auth_service.dart';

import '../../../../../../app/modules/menus/couponHistory/domain/coupon_history_domain.dart';
import '../../../../../../core/api/api_client.dart';
import '../../../../../../core/api/injector.dart';

/// > This class is a service that implements the CouponHistoryRepository interface
class CouponHistoryService implements CouponHistoryRepository {
  ApiClient couponHistoryRepo = getIt.get<ApiClient>();

  @override
 /// It gets the coupon history from the database.
  Future getCouponHistory() async {
   AuthModel userDetails = await AuthService().userDetails();

    final userId = userDetails.result?[0].iUserId.toString();
    final accessToken = userDetails.result?[0].accessToken;

    Map<String, String>? request = {
      "userId": userId ?? '',
    };
    final response = await couponHistoryRepo.restApiCall(
      endpoint: ApiConstant.couponHistory,
      method: ApiMethod.post,
      params: request,
      mHeader: {'access_token': accessToken, 'user_id': userId},
    );
    return response;
  }
}
