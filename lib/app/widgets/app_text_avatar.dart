import 'package:flutter/material.dart';
import 'package:pensol/app/routes/route_names.dart';
import '../../app.dart';
import '../../app/themes/colors.dart';

enum Shape { rectangle, circular, none }

// ignore: must_be_immutable
/// `TextAvatar` is a `StatelessWidget` that displays a `CircleAvatar` with a `Text` widget inside of it
class TextAvatar extends StatelessWidget {
  
  Shape? shape;
  Color? backgroundColor;
  Color? textColor;
  double? size;
  final String? text;
  final double? fontSize;
  final int? numberLetters;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final bool? upperCase;

  TextAvatar(
      {Key? key,
      @required this.text,
      this.textColor,
      this.backgroundColor,
      this.shape,
      this.numberLetters,
      this.size,
      this.fontWeight = FontWeight.bold,
      this.fontFamily,
      this.fontSize = 16,
      this.upperCase = false}) : super(key: key) {
    //assert(numberLetters! > 0);
  }

  @override
  Widget build(BuildContext context) {
    shape = (shape == null) ? Shape.rectangle : shape;
    size = (size == null || size! < 32.0) ? 48.0 : size;
    backgroundColor = _colorBackgroundConfig();
    textColor = _colorTextConfig();
    return _textDisplay();
  }

  Color _colorBackgroundConfig() {
    if (RegExp(r'[A-Z]|').hasMatch(
      _textConfiguration(),
    )) {
      backgroundColor =
          colorData[_textConfiguration()[0].toLowerCase().toString()];
    }
    return backgroundColor!;
  }

  Color _colorTextConfig() {
    if (textColor == null) {
      return Colors.white;
    } else {
      return textColor!;
    }
  }

  String _toString({String? value}) {
    return String.fromCharCodes(
      value!.runes.toList(),
    );
  }

  String _textConfiguration() {
    var newText = text == null ? '?' : _toString(value: text);
    newText = upperCase! ? newText.toUpperCase() : newText;
    var arrayLeeters = newText.trim().split(' ');

    if (arrayLeeters.length > 1 && arrayLeeters.length == numberLetters) {
      return '${arrayLeeters[0][0].trim()}${arrayLeeters[1][0].trim()}';
    }

    return newText[0];
  }

  Widget _buildText() {
    return Text(
      _textConfiguration(),
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
      ),
    );
  }

  _buildTextType() {
    switch (shape) {
      case Shape.rectangle:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        );
      case Shape.circular:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(size! / 2),
        );
      case Shape.none:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        );
      default:
        {
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(size! / 2),
          );
        }
    }
  }

  Widget _textDisplay() {
    return Material(
      shape: _buildTextType(),
      color: backgroundColor,
      child: InkWell(
        onTap: () => navigatorKey.currentState?.pushNamed(AppRoutes.profile),
        child: SizedBox(
          height: size,
          width: size,
          child: Center(
            child: _buildText(),
          ),
        ),
      ),
    );
  }
}