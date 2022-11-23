import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pensol/app/modules/menus/notification/domain/models/notification_model.dart';
import 'package:pensol/app/widgets/base_provider.dart';
import 'package:pensol/app/widgets/dialogs/app_dialog.dart';
import 'package:pensol/core/api/api_constant.dart';
import '../../../../../../app/modules/menus/notification/domain/notification_domain.dart';
import '../../../../../app.dart';


class NotificationProvider extends BaseProvider {
  final _repo = NotificationRepository();



  /// notification model
  NotificationModel _notifications = NotificationModel();

  /// notification getter
  NotificationModel get notifications => _notifications;

  /// notification setter
  void setNotifications(NotificationModel notifications) {
    _notifications = notifications;
    notifyListeners();
  }

  getNotification() async {
    setAppState(AppState.loading);
    try {
      final response = await _repo.getNotification();

      if (response is Response) {
        if (response.statusCode == 200) {
          final notifications = NotificationModel.fromJson(response.data);
          if (notifications.statusCode == 200) {
            setAppState(AppState.loaded);
            setNotifications(notifications);
          } else {
            setAppState(AppState.error);
            AppDialog().error(
              navigatorKey.currentContext!,
              'Error',
              notifications.message ?? '',
              Colors.red,
            );
          }
        } else {
          final notifications = NotificationModel.fromJson(response.data);
          setAppState(AppState.error);
          AppDialog().error(
            navigatorKey.currentContext!,
            'Error',
            notifications.message ?? '',
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
