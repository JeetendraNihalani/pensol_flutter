import 'package:pensol/app/modules/auth/login/domain/models/auth_model.dart';
import 'package:pensol/core/api/api_constant.dart';
import 'package:pensol/core/services/auth_service.dart';

import '../../../../../../app/modules/menus/manualCouponEntry/domain/manual_coupon_code_domain.dart';
import '../../../../../../core/api/api_client.dart';
import '../../../../../../core/api/injector.dart';

class ManualCouponCodeService implements ManualCouponCodeRepository {
  final  _repo = getIt.get<ApiClient>();

  @override
  Future redeemCoupon(String? couponCode) async {
    AuthModel userDetails = await AuthService().userDetails();

    final accessToken = userDetails.result?[0].accessToken;
    final userId = userDetails.result?[0].iUserId.toString();

    Map<String, String>? request = {
      "userId": userId ?? '',
      "couponText": couponCode ?? ''
    };
    final response = await _repo.restApiCall(
      endpoint: ApiConstant.claimCoupon,
      method: ApiMethod.post,
      params: request,
      mHeader: {'access_token': accessToken, 'user_id': userId},
    );
    return response;
  }
}
