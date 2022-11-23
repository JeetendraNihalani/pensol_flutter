import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../app/constants/app_spacing.dart';

/// `AppTextField` is a `StatelessWidget` that displays a `TextField` 
class AppTextField extends StatelessWidget {
  /// constructor
  const AppTextField({
    Key? key,
    this.prefixIcon,
    this.controller,
    this.hintText,
    this.obscureText = false,
    this.inputFormatter,
    this.validator,
    this.onChanged,
    this.textInputAction,
    this.keyboardType,
    this.maxLength,
  }) : super(key: key);

  /// prefix IconData
  final IconData? prefixIcon;

  /// textfield controller
  final TextEditingController? controller;

  /// hint text String
  final String? hintText;

  /// bool obscure text
  final bool obscureText;

  /// text field formatter
  final List<TextInputFormatter>? inputFormatter;

  /// function for validation
  final String? Function(String?)? validator;

  /// function on change
  final Function(String)? onChanged;

  /// text input actions
  final TextInputAction? textInputAction;

  /// keyboard type
  final TextInputType? keyboardType;

  /// int max length
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      keyboardType: keyboardType,
      maxLength: maxLength,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(AppSpacing.md),
        counterText: "",

        prefixIcon: Container(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          margin: const EdgeInsets.only(right: AppSpacing.sm),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.all(
             Radius.circular(8.0)
            ),
          ),
          child: Icon(
            prefixIcon,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
      ),
    );
  }
}
