import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pensol/app/modules/menus/giftStatus/domain/models/gift_status_model.dart';
import 'package:pensol/app/widgets/base_provider.dart';
import 'package:pensol/app/widgets/dialogs/app_dialog.dart';
import 'package:pensol/core/api/api_constant.dart';
import '../../../../../../app/modules/menus/giftStatus/domain/gift_status_domain.dart';
import '../../../../../app.dart';


class GiftStatusProvider extends BaseProvider {
  final _repo = GiftStatusRepository();

  /// gift status model
  GiftStatusModel _giftStatus = GiftStatusModel();

  /// gift status getter
  GiftStatusModel get giftStatus => _giftStatus;

  /// gift status setter
  void setGiftStatus(GiftStatusModel giftStatus) {
    _giftStatus = giftStatus;
    notifyListeners();
  }

  getGiftStatus() async {
    setAppState(AppState.loading);
    try {
      final response = await _repo.getGiftStatus();

      if (response is Response) {
        if (response.statusCode == 200) {
          final giftStatusModel = GiftStatusModel.fromJson(response.data);
          if (giftStatusModel.statusCode == 200) {
            setAppState(AppState.loaded);
            setGiftStatus(giftStatusModel);
          } else {
            setAppState(AppState.error);
            AppDialog().error(
              navigatorKey.currentContext!,
              'Error',
              giftStatusModel.message ?? '',
              Colors.red,
            );
          }
        } else {
          final giftStatusModel = GiftStatusModel.fromJson(response.data);
          setAppState(AppState.error);
          AppDialog().error(
            navigatorKey.currentContext!,
            'Error',
            giftStatusModel.message ?? '',
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
