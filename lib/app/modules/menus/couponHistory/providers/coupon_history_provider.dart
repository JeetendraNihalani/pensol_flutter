import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pensol/app/modules/menus/couponHistory/domain/models/coupon_history_model.dart';
import 'package:pensol/app/widgets/base_provider.dart';
import 'package:pensol/app/widgets/dialogs/app_dialog.dart';
import 'package:pensol/core/api/api_constant.dart';
import '../../../../../../app/modules/menus/couponHistory/domain/coupon_history_domain.dart';
import '../../../../../app.dart';


/// `CouponHistoryProvider` is a `BaseProvider` that provides a `CouponHistory` object
class CouponHistoryProvider extends BaseProvider {
  final _repo = CouponHistoryRepository();


  /// Coupon history model
  CouponHistoryModel _couponHistory = CouponHistoryModel();

  /// Coupon history getter
  CouponHistoryModel get couponHistory => _couponHistory;

  /// Coupon history setter
  void setCouponHistory(CouponHistoryModel couponHistory) {
    _couponHistory = couponHistory;
    notifyListeners();
  }

  /// It returns a coupon history.
  getCouponHistory() async {
    setAppState(AppState.loading);
    try {
      final response = await _repo.getCouponHistory();

      if (response is Response) {
        if (response.statusCode == 200) {
          final couponHistory = CouponHistoryModel.fromJson(response.data);
          if (couponHistory.statusCode == 200) {
            setAppState(AppState.loaded);
            setCouponHistory(couponHistory);
          } else {
            setAppState(AppState.error);
            AppDialog().error(
              navigatorKey.currentContext!,
              'Error',
              couponHistory.message ?? '',
              Colors.red,
            );
          }
        } else {
          final couponHistory = CouponHistoryModel.fromJson(response.data);
          setAppState(AppState.error);
          AppDialog().error(
            navigatorKey.currentContext!,
            'Error',
            couponHistory.message ?? '',
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
