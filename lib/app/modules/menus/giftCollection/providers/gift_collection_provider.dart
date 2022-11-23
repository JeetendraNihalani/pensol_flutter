import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pensol/app/modules/menus/giftCollection/domain/models/gift_collection_model.dart';
import 'package:pensol/app/widgets/base_provider.dart';
import 'package:pensol/app/widgets/dialogs/app_dialog.dart';
import 'package:pensol/core/api/api_constant.dart';
import '../../../../../../app/modules/menus/giftCollection/domain/gift_collection_domain.dart';
import '../../../../../app.dart';


/// `GiftCollectionProvider` is a `BaseProvider` that provides a `GiftCollection` to the
/// `GiftCollectionView`
class GiftCollectionProvider extends BaseProvider {
  final _repo = GiftCollectionRepository();

  /// Gift collection model
  GiftCollectionModel _giftCollection = GiftCollectionModel();

  /// Gift collection getter
  GiftCollectionModel get giftCollection => _giftCollection;

  /// Gift collection setter
  void setGiftCollection(GiftCollectionModel giftCollection) {
    _giftCollection = giftCollection;
    notifyListeners();
  }

  /// image file
  XFile? _giftImage;

  /// image file getter
  XFile? get giftImage => _giftImage;

  /// image file setter
  void setGiftImage(XFile? giftImage) {
    _giftImage = giftImage;
    notifyListeners();
  }

  /// method to get gift collection
  getGiftCollection() async {
    setAppState(AppState.loading);
    try {
      final response = await _repo.getGiftCollection();

      if (response is Response) {
        if (response.statusCode == 200) {
          final giftCollection = GiftCollectionModel.fromJson(response.data);
          if (giftCollection.statusCode == 200) {
            setAppState(AppState.loaded);
            setGiftCollection(giftCollection);
          } else {
            setAppState(AppState.error);
            AppDialog().error(
              navigatorKey.currentContext!,
              'Error',
              giftCollection.message ?? '',
              Colors.red,
            );
          }
        } else {
          final giftCollection = GiftCollectionModel.fromJson(response.data);
          setAppState(AppState.error);
          AppDialog().error(
            navigatorKey.currentContext!,
            'Error',
            giftCollection.message ?? '',
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

 
  /// Calling the `collecGift` method.
  collecGift(String giftId,XFile? image) async {
    setButtonState(AppState.loading);
    try {
      final response = await _repo.collectGift(giftId,image);

      if (response is Response) {
        if (response.statusCode == 200) {
          final giftCollection = GiftCollectionModel.fromJson(response.data);
          if (giftCollection.statusCode == 200) {
            setButtonState(AppState.loaded);
            setGiftCollection(giftCollection);
          } else {
            setButtonState(AppState.error);
            AppDialog().error(
              navigatorKey.currentContext!,
              'Error',
              giftCollection.message ?? '',
              Colors.red,
            );
          }
        } else {
          final giftCollection = GiftCollectionModel.fromJson(response.data);
          setButtonState(AppState.error);
          AppDialog().error(
            navigatorKey.currentContext!,
            'Error',
            giftCollection.message ?? '',
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
  }

}
