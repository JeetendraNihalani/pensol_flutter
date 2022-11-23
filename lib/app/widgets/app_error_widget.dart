import 'package:flutter/material.dart';
import '../../app/widgets/app_spacer.dart';

import 'app_elevated_button.dart';

/// `AppErrorWidget` is a stateless widget that displays an error message
class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget(
    this.errorTitle,
    this.errorMessage, {
    Key? key,
    this.onButtonPressed,
  }) : super(key: key);

  /// string error title
  final String errorTitle;

  /// string error message
  final String errorMessage;

  /// action button function
  final Function()? onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          errorTitle,
          style: Theme.of(context).textTheme.headline5,
        ),
        AppSpacer.p16(),
        Text(errorMessage),
        AppSpacer.p16(),
        AppElevatedButton('Retry')
      ],
    );
  }
}
