import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pensol/app/modules/home/providers/home_provider.dart';
import 'package:pensol/app/widgets/base_provider.dart';
import 'package:pensol/app/widgets/dialogs/app_dialog.dart';
import 'package:pensol/core/api/api_constant.dart';
import '../../../../../../app/modules/menus/manualCouponEntry/domain/manual_coupon_code_domain.dart';
import '../../../../../app.dart';


class ManualCouponCodeProvider extends BaseProvider {
  final _repo = ManualCouponCodeRepository();

  redeemCoupon(String? couponCode) async {
    setAppState(AppState.loading);
    try {
      final response = await _repo.redeemCoupon(couponCode);

      if (response is Response) {
        if (response.statusCode == 200) {
          setAppState(AppState.loaded);
          HomeProvider().getMobileSettings();
          if (response.data['StatusCode'] == 200) {
            AppDialog().success(
              navigatorKey.currentContext!,
              'Success',
              response.data['Message'] ?? '',
              Colors.green,
            );
          } else {
            AppDialog().error(
              navigatorKey.currentContext!,
              'Error',
              response.data['Message'] ?? '',
              Colors.red,
            );
          }
        } else {
          setAppState(AppState.error);
          AppDialog().error(
            navigatorKey.currentContext!,
            'Error',
            response.data['Message'] ?? '',
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
