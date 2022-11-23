import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pensol/app/constants/app_string.dart';
import 'package:pensol/app/modules/auth/login/domain/models/auth_model.dart';
import 'package:pensol/app/routes/route_names.dart';
import 'package:pensol/app/widgets/base_provider.dart';
import 'package:pensol/app/widgets/dialogs/app_dialog.dart';
import 'package:pensol/core/api/api_constant.dart';
import 'package:pensol/core/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../app/modules/home/domain/repository/home_repository.dart';
import '../../../../app.dart';


/// `HomeProvider` is a class that extends `ChangeNotifier` and is used to provide data to the
/// `HomePage` widget
class HomeProvider extends BaseProvider {
  final _repo = HomeRepository();

  /// user auth model
  AuthModel _userDetails = AuthModel();

  /// user details getter
  AuthModel get userDetails => _userDetails;

  /// This function is used to get the user details from the database.
  getUserDetails() async {
    _userDetails = await AuthService().userDetails();
    notifyListeners();
  }

  /// user available points
  String? _userAvailablePoints;

  /// user available points getter
  String? get userAvailablePoints => _userAvailablePoints;

  /// user required points
  String? _userRequiredPoints;

  /// user required points getter
  String? get userRequiredPoints => _userRequiredPoints;

  /// user nearest gift
  String? _userNearestGift;

  /// user nearest gift
  String? get userNearestGift => _userNearestGift;

  getMobileSettings() async {
    setAppState(AppState.loading);
    try {
      final response = await _repo.getMobileSetting();

      if (response is Response) {
        if (response.statusCode == 200) {
          if (response.data['StatusCode'] == 200) {
            setAppState(AppState.loaded);
            _userAvailablePoints =
                response.data['Result'][1][0]['vAvailablePoints'].toString();
            _userRequiredPoints =
                response.data['Result'][1][0]['vNearestGiftPoint'].toString();
            _userNearestGift =
                response.data['Result'][1][0]['vNearestGiftName'].toString();
            notifyListeners();

          }
        } else {
          final authModel = AuthModel.fromJson(response.data);
          setAppState(AppState.error);

          AppDialog().error(
            navigatorKey.currentContext!,
            'Error',
            authModel.message ?? '',
            Colors.red,
          );
        }
      }
    } catch (e) {
      setAppState(AppState.error);
      AppDialog().error(
        navigatorKey.currentContext!,
        'Error',
        e.toString(),
        Colors.red,
      );
    }
  }
}
