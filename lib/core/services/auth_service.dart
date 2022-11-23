import 'dart:convert';

import 'package:pensol/app/constants/app_string.dart';
import 'package:pensol/app/modules/auth/login/domain/models/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// > This class is responsible for authenticating users
class AuthService {
  /// get user details from local storage
  /// return userdetails if found or return null
  userDetails() async {
    final _sharedPrefs = await SharedPreferences.getInstance();

    final _authModel = AuthModel.fromJson(
      json.decode(
        _sharedPrefs.getString(AppString.auth) ?? '{}',
      ),
    );

    if (_authModel.result != null) {
      return _authModel;
    }else{
      return null;
    }
    
  }
}
