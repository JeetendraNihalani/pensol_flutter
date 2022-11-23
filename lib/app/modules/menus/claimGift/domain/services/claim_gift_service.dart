import 'package:pensol/app/modules/auth/login/domain/models/auth_model.dart';
import 'package:pensol/core/api/api_constant.dart';
import 'package:pensol/core/services/auth_service.dart';

import '../../../../../../app/modules/menus/claimGift/domain/repository/claim_gift_repository.dart';
import '../../../../../../core/api/api_client.dart';
import '../../../../../../core/api/injector.dart';

class ClaimGiftService implements ClaimGiftRepository {
  ApiClient claimGiftRepo = getIt.get<ApiClient>();

  @override
  Future getClaimGiftList() async {
    AuthModel userDetails = await AuthService().userDetails();

    final accessToken = userDetails.result?[0].accessToken;

    Map<String, String>? request = {
      "userId": '0',
    };
    final response = await claimGiftRepo.restApiCall(
      endpoint: ApiConstant.claimGift,
      method: ApiMethod.post,
      params: request,
      mHeader: {'access_token': accessToken, 'user_id': '0'},
    );
    return response;
  }

  @override
  Future redeemGift(String giftId, String userId, String qty) async {

    AuthModel userDetails = await AuthService().userDetails();

    final accessToken = userDetails.result?[0].accessToken;

    Map<String, String>? request = {
      "giftId": giftId,
      "userId":userId,
      "qty" : qty,
    };
    final response = await claimGiftRepo.restApiCall(
      endpoint: ApiConstant.redeemGift,
      method: ApiMethod.post,
      params: request,
      mHeader: {'access_token': accessToken, 'user_id': userId},
    );
    return response;
  }
}
