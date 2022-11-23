import 'package:flutter/material.dart';
import 'package:pensol/app/constants/app_spacing.dart';
import 'package:pensol/app/constants/app_string.dart';
import 'package:pensol/app/routes/route_names.dart';
import 'package:pensol/app/widgets/app_elevated_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app.dart';
import '../../../core/utils/extensions/screen_extension.dart';

/// to display different dialogs
class AppDialog {
  /// method show success dialog
  void success(
    BuildContext context,
    String title,
    String message,
    Color? color, {
    String? button,
    Function()? onButtonTap,
  }) {
    _showDialog(
      context,
      title,
      message,
      color: color,
      button: button,
      onButtonTap: onButtonTap,
    );
  }

  /// method show error dialog
  void error(
    BuildContext context,
    String title,
    String message,
    Color? color, {
    String? button,
    Function()? onButtonTap,
  }) {
    _showDialog(
      context,
      title,
      message,
      color: color,
      button: button,
      onButtonTap: onButtonTap,
    );
  }

  /// method show warning dialog
  void warning(
    BuildContext context,
    String title,
    String message,
    Color? color, {
    String? button,
    Function()? onButtonTap,
  }) {
    _showDialog(
      context,
      title,
      message,
      color: color,
      button: button,
      onButtonTap: onButtonTap,
    );
  }

  /// method show info dialog
  void info(
    BuildContext context,
    String title,
    String message,
    Color? color, {
    String? button,
    Function()? onButtonTap,
  }) {
    _showDialog(
      context,
      title,
      message,
      color: color,
      button: button,
      onButtonTap: onButtonTap,
    );
  }

  /// method to show logout dialog
  void exitApp(
    BuildContext context,
  ) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Logout'),
            content: const Text('Are you sure you want to logout?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () async {
                  final _sharedPrefs = await SharedPreferences.getInstance();
                  _sharedPrefs.setString(AppString.auth, '{}');
                  navigatorKey.currentState?.pushNamedAndRemoveUntil(AppRoutes.login, (Route<dynamic> route) => false);
                },
                child: const Text('Yes'),
              ),
            ],
          );
        });
  }

  /// dialog
  void _showDialog(
    BuildContext context,
    String title,
    String message, {
    Color? color = Colors.red,
    String? button,
    Function()? onButtonTap,
  }) {
    showGeneralDialog(
      context: context,
      barrierLabel: '',
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        final messageStyle = Theme.of(context)
            .textTheme
            .subtitle1
            ?.copyWith(color: Colors.black);
        final titleStyle = Theme.of(context).textTheme.headline6?.copyWith(
              color: color,
            );
        return Center(
          child: Container(
              height: 200,
              margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Container(
                    height: 50,
                    width: context.width,
                    color: color?.withOpacity(0.1),
                    padding: const EdgeInsets.only(left: AppSpacing.md),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title,
                        style: titleStyle,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: AppSpacing.md,
                        top: AppSpacing.md,
                      ),
                      child: Scrollbar(
                        isAlwaysShown: true,
                        child: SingleChildScrollView(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              message,
                              style: messageStyle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                        child: SizedBox(
                          width: button == null ? 100 : 150,
                          height: 40,
                          child: AppElevatedButton(
                            'OK',
                            onTap: onButtonTap ??
                                () => navigatorKey.currentState?.pop(),
                            height: 50,
                            width: 100,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }
}
