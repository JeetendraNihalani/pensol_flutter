import 'package:flutter/material.dart';
import 'package:pensol/app/constants/app_spacing.dart';

/// `AppElevatedButton` is a `StatelessWidget` that displays a `MaterialButton` with a `elevation` of
/// `4.0` and a `color` of `Colors.white`
class AppElevatedButton extends StatelessWidget {
  AppElevatedButton(
    this.title, {
    Key? key,
    this.onTap,
        this.backgroundColor,
    this.width = double.infinity,
    this.height = 50,
  }) : super(key: key);

  /// string button title
  final String title;

  /// function button pressed
  final Function()? onTap;

  /// double button width
  final double width;

  /// double button height
  final double height;

  var backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        child: Text(title),
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: backgroundColor,
            shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.sm)),
        )),
      ),
    );
  }
}
