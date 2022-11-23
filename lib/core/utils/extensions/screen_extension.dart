

import 'package:flutter/cupertino.dart';

/// Extending the BuildContext class with the ScreenUtil class.
extension ScreenUtil on BuildContext {

  Size get size => MediaQuery.of(this).size;

  /// check if the screen is portrait
  bool get isPortrait => size.width < size.height;

  /// check if the screen is landscape
  bool get isLandscape => size.width > size.height;

  /// width based on orientation
  double get width => isPortrait ? size.width : size.height;

  /// height based on orientation
  double get height => isPortrait ? size.height : size.width;
}