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
import '../domain/repository/forgotPin_repository.dart';

/// `ForgotPinProvider` is a `BaseProvider` that has a `LoginService` and a `LoginModel` and it's `init`
/// method calls `LoginService.login` and then `LoginModel.setUser`

class ForgotPinProvider extends BaseProvider {


  /// Creating an instance of the ForgotPinRepository class.
  final _forgotPinRepo = ForgotPinRepository();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CheckUserRegisterModel? checkUserRegisterModel;
  var _verificationId;
  var _otp;
  String? _newPin;
  String? _confirmPin;


  void setOtp(String otp) {
    _otp = otp;
  }

  void setNewPin(String newPin) {
    _newPin = newPin;
    notifyListeners();
  }

  void setConfirmPin(String confirmPin) {
    _confirmPin = confirmPin;
    notifyListeners();
  }



  String? get otp => _otp;



  /// A function that is called when the user clicks on the ForgotPin button.
  // /// A function that is called when the user clicks on the ForgotPin button.
  // forgotPin(
  //     BuildContext context
  //     ) async {
  //   setAppState(AppState.loading);
  //   try {
  //     final response = await _forgotPinRepo.forgotPin(
  //       _newPin,
  //       _confirmPin,
  //     );
  //
  //     if (response is Response) {
  //       if (response.statusCode == 200) {
  //         final authModel = AuthModel.fromJson(response.data);
  //         if (authModel.statusCode == 200) {
  //           setAppState(AppState.loaded);
  //           Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
  //         } else {
  //           setAppState(AppState.error);
  //           AppDialog().error(
  //             navigatorKey.currentContext!,
  //             'Error',
  //             authModel.message ?? '',
  //             Colors.red,
  //           );
  //         }
  //       } else {
  //         final authModel = AuthModel.fromJson(response.data);
  //         setAppState(AppState.error);
  //
  //         AppDialog().error(
  //           navigatorKey.currentContext!,
  //           'Error',
  //           authModel.message ?? '',
  //           Colors.red,
  //         );
  //       }
  //     }
  //   } catch (e) {
  //     setAppState(AppState.error);
  //     AppDialog().error(
  //       navigatorKey.currentContext!,
  //       'Error',
  //       e.toString(),
  //       Colors.red,
  //     );
  //   }
  // }

  /// A function that is called when the user clicks on the ForgotPin button and check user register or not.
  checkUserRegister(
      String? MobileNo,
      ) async {
    setAppState(AppState.loading);
    try {
      final response = await _forgotPinRepo.checkUserRegister(
        MobileNo
      );
      if (response is Response) {
        if (response.statusCode == 200) {
          checkUserRegisterModel = CheckUserRegisterModel.fromJson(response.data);
          if (checkUserRegisterModel?.statusCode == 200) {
            setAppState(AppState.loaded);
            //navigate
          } else {
            setAppState(AppState.error);
            AppDialog().error(
              navigatorKey.currentContext!,
              'Error',
              checkUserRegisterModel?.message ?? '',
              Colors.red,
            );
          }
        } else {
          checkUserRegisterModel = CheckUserRegisterModel.fromJson(response.data);
          setAppState(AppState.error);

          AppDialog().error(
            navigatorKey.currentContext!,
            'Error',
            checkUserRegisterModel?.message ?? '',
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


  sendOTP(String? mobileNumber, BuildContext context,[String? appRoutes]) {
    setButtonState(AppState.loading);
    setAppState(AppState.loading);
    firebaseAuth.verifyPhoneNumber(
        phoneNumber: "+91" + mobileNumber!,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential mAuth) async {
        },
        verificationFailed: (FirebaseAuthException mAuth) async {
          //AppToast().showFailure(message: mAuth.toString());
          setAppState(AppState.error);
          setButtonState(AppState.error);
        },
        codeSent: (verificationId, forceSendToken) async {
          _verificationId = verificationId;
          AppDialog().success(
            navigatorKey.currentContext!,
            'Error',
            'OTP sent',
            Colors.red,
          );
          appRoutes != null ? Navigator.pushNamed(context, appRoutes):print('OTP sent');
          setAppState(AppState.loaded);
          setAppState(AppState.loaded);
        },
        codeAutoRetrievalTimeout: (verificationId) {
          setAppState(AppState.empty);
          setAppState(AppState.empty);
        });
  }

  verifyOtp(BuildContext context,[String? appRoute]) async {
    setAppState(AppState.loading);
    setButtonState(AppState.loading);
    var phoneCredential = PhoneAuthProvider.credential(verificationId: _verificationId ?? "", smsCode: _otp);
    try {
      await FirebaseAuth.instance.signInWithCredential(phoneCredential).then((UserCredential result) {
        appRoute != null ? Navigator.pushNamed(context, appRoute): print('verified');
        setAppState(AppState.loaded);
        setButtonState(AppState.loaded);
      }).catchError((error) {
        if (error is PlatformException) {
          var err = error;
          if (err.code == "ERROR_SESSION_EXPIRED") {
            //AppToast().showFailure(message: err.message ?? "");
          } else {
            //AppToast().showFailure(message: err.message ?? "");
          }
        } else {
          //AppToast().showFailure(message: "Something want wrong");
        }
        setAppState(AppState.error);
        setButtonState(AppState.error);
      });
    } on FirebaseAuthException catch (e) {
      //AppToast().showFailure(message: e.message ?? "");
      setAppState(AppState.error);
      setButtonState(AppState.error);
    }
  }


}
