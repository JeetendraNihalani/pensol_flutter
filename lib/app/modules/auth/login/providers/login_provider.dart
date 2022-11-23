import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pensol/app/constants/app_string.dart';
import 'package:pensol/app/modules/auth/login/domain/models/auth_model.dart';
import 'package:pensol/app/widgets/base_provider.dart';
import 'package:pensol/app/routes/route_names.dart';
import 'package:pensol/app/widgets/dialogs/app_dialog.dart';
import 'package:pensol/core/api/api_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../app/modules/auth/login/domain/repository/login_repository.dart';
import '../../../../../app.dart';

/// `LoginProvider` is a `BaseProvider` that has a `LoginService` and a `LoginModel` and it's `init`
/// method calls `LoginService.login` and then `LoginModel.setUser`
class LoginProvider extends BaseProvider {

  
  /// Creating an instance of the LoginRepository class.
  final _loginRepo = LoginRepository();



  /// A function that is called when the user clicks on the login button.
  doLogin(
    String? mobileNumber,
    String? password,
    String? deviceMake,
    String? deviceName,
    String? deviceToken,
  ) async {
    setAppState(AppState.loading);
    final _sharedPrefs = await SharedPreferences.getInstance();
    try {
      final response = await _loginRepo.login(
        mobileNumber,
        password,
        deviceMake,
        deviceName,
        deviceToken,
      );

      if (response is Response) {
        if (response.statusCode == 200) {
          final authModel = AuthModel.fromJson(response.data);
          if (authModel.statusCode == 200) {
            setAppState(AppState.loaded);
            _sharedPrefs.setString(AppString.auth, json.encode(authModel));
            navigatorKey.currentState
                ?.pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
          } else {
            setAppState(AppState.error);
            AppDialog().error(
              navigatorKey.currentContext!,
              'Error',
              authModel.message ?? '',
              Colors.red,
            );
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
