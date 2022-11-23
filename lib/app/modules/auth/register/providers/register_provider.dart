import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pensol/app/constants/app_string.dart';
import 'package:pensol/app/modules/auth/forgotPassword/domain/models/check_user_register_model.dart';
import 'package:pensol/app/modules/auth/login/domain/models/auth_model.dart';
import 'package:pensol/app/widgets/base_provider.dart';
import 'package:pensol/app/routes/route_names.dart';
import 'package:pensol/app/widgets/dialogs/app_dialog.dart';
import 'package:pensol/core/api/api_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../app/modules/auth/login/domain/repository/login_repository.dart';
import '../../../../../app.dart';
import '../domain/models/register_model.dart';
import '../domain/repository/register_repository.dart';


class RegisterProvider extends BaseProvider {


  /// Creating an instance of the RegisterRepository class.
  final _registerRepo = RegisterRepository();

  RegisterModel? registerModel;

  // register data
  String? _name;
  String? _workshopName;
  String? _roadName;
  String? _pincode;
  String? _city;
  String? _state;
  String? _mobileNumber;
  String? _aadharNumber;
  String? _distributerName;
  String? _pensolSalePersonName;
  String? _imagePath;
  String? _newPin;

  void setnewPin(String newPin) {
    _newPin = newPin;
    notifyListeners();
  }

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setWorkshop(String Workshop) {
    _workshopName = Workshop;
    notifyListeners();
  }

  void setRoadName(String RoadName) {
    _roadName = RoadName;
    notifyListeners();
  }

  void setPincode(String Pincode) {
    _pincode = Pincode;
    notifyListeners();
  }

  void setCity(String City) {
    _city = City;
    notifyListeners();
  }

  void setState(String State) {
    _state = State;
    notifyListeners();
  }

  void setMobileNumber(String MobileNumber) {
    _mobileNumber = MobileNumber;
    notifyListeners();
  }

  void setAadharNumber(String AadharNumber) {
    _aadharNumber = AadharNumber;
    notifyListeners();
  }

  void setDistributorName(String DistributorName) {
    _distributerName = DistributorName;
    notifyListeners();
  }

  void setPensolSalePerson(String PensolSalePerson) {
    _pensolSalePersonName = PensolSalePerson;
    notifyListeners();
  }



  /// A function that is called when the user clicks on the Register button and create new user account.
  register(String token) async {
    setAppState(AppState.loading);
    try {
      final response = await _registerRepo.register(
          _name ?? '',
          _workshopName ?? '',
          _roadName ?? '',
          _pincode ?? '',
          _city ?? '',
          _state ?? '',
          _mobileNumber ?? '',
          _aadharNumber ?? '',
          _distributerName ?? '',
          _pensolSalePersonName ?? '',
          "",
          token,
          _newPin ?? ''
      );
      if (response is Response) {
        if (response.statusCode == 200) {
          registerModel = RegisterModel.fromJson(response.data);
          if (registerModel?.statusCode == 200) {
            setAppState(AppState.loaded);
            //navigate
          } else {
            setAppState(AppState.error);
            AppDialog().error(
              navigatorKey.currentContext!,
              'Error',
              registerModel?.message ?? '',
              Colors.red,
            );
          }
        } else {
          registerModel = RegisterModel.fromJson(response.data);
          setAppState(AppState.error);

          AppDialog().error(
            navigatorKey.currentContext!,
            'Error',
            registerModel?.message ?? '',
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
