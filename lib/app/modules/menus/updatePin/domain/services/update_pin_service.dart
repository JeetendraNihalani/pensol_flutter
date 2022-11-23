import 'package:pensol/app/modules/auth/login/domain/models/auth_model.dart';
import 'package:pensol/core/api/api_constant.dart';
import 'package:pensol/core/services/auth_service.dart';

import '../../../../../../app/modules/menus/updatePin/domain/update_pin_domain.dart';
import '../../../../../../core/api/api_client.dart';
import '../../../../../../core/api/injector.dart';

class UpdatePinService implements UpdatePinRepository {

    final _repo = getIt.get<ApiClient>();

  @override
  Future updatePin(String? newPin, String? confirmPin,var userId) async {

    Map<String, String>? request = {
      "userId": userId.toString() ?? '',
      "newPIN": newPin ?? '',
      "confirmPIN": confirmPin ?? '',
    };
    final response = await _repo.restApiCall(
      endpoint: ApiConstant.updatePin,
      method: ApiMethod.post,
      params: request,
      mHeader: {'user_id': userId},
    );
    return response;
  }


}
