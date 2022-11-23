import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pensol/app/modules/menus/claimGift/domain/models/get_claim_gift_list_model.dart';
import 'package:pensol/app/widgets/base_provider.dart';
import 'package:pensol/app/widgets/dialogs/app_dialog.dart';
import 'package:pensol/core/api/api_constant.dart';
import '../../../../../../app/modules/menus/claimGift/domain/claim_gift_domain.dart';
import '../../../../../app.dart';

import '../domain/models/gist_claim_model.dart';

/// > This class is a provider that handles the logic for the claim gift screen
class ClaimGiftProvider extends BaseProvider {
  /// Creating an instance of the repository class.
  final _repo = ClaimGiftRepository();

  /// claim gift list
  GetClaimGiftListModel _claimGiftList = GetClaimGiftListModel();

  ///GiftClaimModel for redeeming gifts
  GiftClaimModel? giftClaimModel;

  /// claim gift list getter
  GetClaimGiftListModel get claimgiftList => _claimGiftList;

  /// claim gift list setter
  void setClaimGiftList(GetClaimGiftListModel claimGiftList) {
    _claimGiftList = claimGiftList;
    notifyListeners();
  }

  /// An asynchronous function that returns a  claim gift.
  getClaimGifts() async {
    setAppState(AppState.loading);
    try {
      final response = await _repo.getClaimGiftList();

      if (response is Response) {
        if (response.statusCode == 200) {
          final giftclaimListModel =
              GetClaimGiftListModel.fromJson(response.data);
          if (giftclaimListModel.statusCode == 200) {
            setAppState(AppState.loaded);
            setClaimGiftList(giftclaimListModel);
          } else {
            setAppState(AppState.error);
            AppDialog().error(
              navigatorKey.currentContext!,
              'Error',
              giftclaimListModel.message ?? '',
              Colors.red,
            );
          }
        } else {
          final giftclaimListModel =
              GetClaimGiftListModel.fromJson(response.data);
          setAppState(AppState.error);
          AppDialog().error(
            navigatorKey.currentContext!,
            'Error',
            giftclaimListModel.message ?? '',
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

  /// An asynchronous function that help to redeem gifts.
  redeemGift(String giftId, String userId) async {
    setAppState(AppState.loading);
    try {
      final response = await _repo.redeemGift(giftId, userId, "1");

      if (response is Response) {
        if (response.statusCode == 200) {
          giftClaimModel = GiftClaimModel.fromJson(response.data);
          if (giftClaimModel?.statusCode == 200) {
            setAppState(AppState.loaded);
            AppDialog().success(
              navigatorKey.currentContext!,
              'Gift Redeemed',
              giftClaimModel?.message ?? '',
              Colors.green,
            );
            getClaimGifts();
          } else {
            setAppState(AppState.error);
            AppDialog().error(
              navigatorKey.currentContext!,
              'Error',
              giftClaimModel?.message ?? '',
              Colors.red,
            );
          }
        } else {
          giftClaimModel = GiftClaimModel.fromJson(response.data);
          setAppState(AppState.error);
          AppDialog().error(
            navigatorKey.currentContext!,
            'Error',
            giftClaimModel?.message ?? '',
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

  /// Incrementing the quantity of the item.
  incrementQty(int index, int qty) {
    qty++;
    _claimGiftList.claimGiftListResult?[index].giftQty = qty;
    notifyListeners();
  }

  /// Decrementing the quantity of the item.
  decrementQty(int index, int qty) {
    qty--;
    _claimGiftList.claimGiftListResult?[index].giftQty = qty;
    notifyListeners();
  }
}
