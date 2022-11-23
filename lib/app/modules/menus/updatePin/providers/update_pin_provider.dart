import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pensol/app/modules/menus/updatePin/domain/models/update_pin_model.dart';
import 'package:pensol/app/widgets/base_provider.dart';
import 'package:pensol/app/widgets/dialogs/app_dialog.dart';
import 'package:pensol/core/api/api_constant.dart';
import '../../../../../../app/modules/menus/updatePin/domain/update_pin_domain.dart';
import '../../../../../app.dart';


class UpdatePinProvider extends BaseProvider {
  final _repo = UpdatePinRepository();
  UpdatePinModel? updatePinModel;

  /// text
  String? _oldPin;
  String? _newPin;
  String? _confirmPin;
  var _userId;

  /// text  getter
  String? get oldPin => _oldPin;
  String? get newPin => _newPin;
  String? get confirmPin => _confirmPin;

  void setUserID(var userId) {
    _userId = userId;
  }

  /// text  setter
  void setOldPin(String? oldPin) {
    _oldPin = oldPin;
    notifyListeners();
  }

  void setnewPin(String? newPin) {
    _newPin = newPin;
    notifyListeners();
  }

  void setConfirmPin(String? confirmPin) {
    _confirmPin = confirmPin;
    notifyListeners();
  }

  /// api call to update pin
  updatePin() async {
    final isNewPinMatched = newPin == confirmPin;
    if (isNewPinMatched) {
      setButtonState(AppState.loading);
      try {
        final response = await _repo.updatePin(_newPin, _confirmPin,_userId);

        if (response is Response) {
          if (response.statusCode == 200) {
            updatePinModel = UpdatePinModel.fromJson(response.data);
            if (updatePinModel?.statusCode == 200) {
              setButtonState(AppState.loaded);
              AppDialog().success(
                navigatorKey.currentContext!,
                'Success',
                updatePinModel?.message ?? '',
                Colors.green,
              );
            } else {
              setButtonState(AppState.error);
              AppDialog().error(
                navigatorKey.currentContext!,
                'Error',
                updatePinModel?.message ?? '',
                Colors.red,
              );
            }
          } else {
            updatePinModel = UpdatePinModel.fromJson(response.data);
            setButtonState(AppState.error);
            AppDialog().error(
              navigatorKey.currentContext!,
              'Error',
              updatePinModel?.message ?? '',
              Colors.red,
            );
          }
        }
      } catch (e) {
        setButtonState(AppState.error);
        AppDialog().error(
          navigatorKey.currentContext!,
          'Error',
          e.toString(),
          Colors.red,
        );
      }
    }else{
      setButtonState(AppState.error);
      AppDialog().error(
          navigatorKey.currentContext!,
          'Error',
          'new Pin and Confirm Pin not matching',
          Colors.red,
        );
    }
  }
}
