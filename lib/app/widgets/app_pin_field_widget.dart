import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import '../../core/utils/extensions/screen_extension.dart';

/// This class is a stateless widget that displays a pin field
class AppPinFieldWidget extends StatelessWidget {
  const AppPinFieldWidget({
    Key? key,
    this.controller,
    this.onChanged,
    this.maxLength = 4,
    this.pinBoxWidth = 50,
    this.pinBoxHeight = 64
  }) : super(key: key);

  /// TextEditingController for pincode field
  final TextEditingController? controller;

  /// function on changed
  final Function(String)? onChanged;

  /// maxLength for pindigit
  final int maxLength;

  /// maxLength for pindigit
  final double pinBoxWidth;

  /// maxLength for pindigit
  final double pinBoxHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Align(
        child: PinCodeTextField(
          autofocus: true,
          controller: controller,
          hideCharacter: true,
          highlight: true,
          maxLength: maxLength,
          maskCharacter: "*",
          onTextChanged: onChanged,
          pinBoxWidth: pinBoxWidth,
          pinBoxHeight: pinBoxHeight,
          hasUnderline: true,
          wrapAlignment: WrapAlignment.spaceEvenly,
          pinBoxDecoration: ProvidedPinBoxDecoration.defaultPinBoxDecoration,
          pinTextStyle: const TextStyle(fontSize: 22.0),
          pinTextAnimatedSwitcherTransition:
              ProvidedPinBoxTextAnimation.scalingTransition,
          pinTextAnimatedSwitcherDuration: const Duration(milliseconds: 300),
          highlightAnimationBeginColor: Colors.black,
          highlightAnimationEndColor: Colors.white12,
          keyboardType: TextInputType.number,
        ),
      ),
    );
  }
}
