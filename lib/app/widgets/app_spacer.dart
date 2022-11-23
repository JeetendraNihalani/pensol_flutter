import 'package:flutter/material.dart';

/// > A widget that adds horizontal and vertical space between widgets
class AppSpacer extends StatelessWidget {
  const AppSpacer._({Key? key, this.h, this.w}) : super(key: key);

  factory AppSpacer.p48() => const AppSpacer._(
        h: 48,
        w: 48,
      );
  factory AppSpacer.p32() => const AppSpacer._(
        h: 32,
        w: 32,
      );
  factory AppSpacer.p24() => const AppSpacer._(
        h: 24,
        w: 24,
      );
  factory AppSpacer.p16() => const AppSpacer._(
        h: 16,
        w: 16,
      );
  factory AppSpacer.p8() => const AppSpacer._(
        h: 8,
        w: 8,
      );
  factory AppSpacer.p4() => const AppSpacer._(
        h: 4,
        w: 4,
      );

  /// height of the sizedBox
  final double? h;

  /// width of the sizedBox
  final double? w;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: w,
      height: h,
    );
  }
}
