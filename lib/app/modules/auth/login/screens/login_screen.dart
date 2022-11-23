import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pensol/app/modules/auth/login/providers/login_provider.dart';
import 'package:pensol/app/routes/route_names.dart';
import 'package:pensol/app/widgets/app_loading_widget.dart';
import 'package:pensol/core/api/api_constant.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/utils/extensions/validation_extension.dart';
import '../../../../../../app/constants/app_spacing.dart';
import '../../../../../../app/constants/app_string.dart';
import '../../../../../../app/widgets/app_elevated_button.dart';
import '../../../../../../app/widgets/app_spacer.dart';
import '../../../../../../app/widgets/app_text_field.dart';

/// This class is a stateful widget that creates a stateful widget called LoginScreen
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  /// form key to validate mobile and password
  final _loginFormKey = GlobalKey<FormState>();

  /// text controller for mobile number
  final _mobileController = TextEditingController();

  /// text controller for password
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    /// A way to access the provider from the context.
    final loginProvider = context.read<LoginProvider>();
    return Scaffold(
      body: Form(
        key: _loginFormKey,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100.0,
                child: Text(
                  AppString.appName,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              AppSpacer.p48(),
              AppTextField(
                maxLength: 10,
                prefixIcon: Icons.phone_android,
                hintText: AppString.mobileHint,
                controller: _mobileController,
                keyboardType: TextInputType.phone,
                inputFormatter: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                ],
                validator: (mobile) => mobile!.isMobileValid(),
              ),
              AppSpacer.p8(),
              AppTextField(
                maxLength: 4,
                prefixIcon: Icons.lock,
                hintText: AppString.passwordHint,
                controller: _passwordController,
                keyboardType: TextInputType.phone,
                inputFormatter: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                ],
                validator: (mobile) => mobile!.isPasswordValid(),
              ),
              AppSpacer.p4(),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.forgotPin);
                  },
                  child: const Text(AppString.forgotPin),
                ),
              ),
              AppSpacer.p32(),
             /// A widget that listens to the changes in the provider and rebuilds the widget.
              Consumer<LoginProvider>(
                builder: (context, state, child) {
                  if (state.appState == AppState.loading) {
                    return const AppLoadingWidget();
                  } else {
                    return AppElevatedButton(
                      AppString.login,
                      onTap: () async {
                        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
                        AndroidDeviceInfo androidInfo =
                            await deviceInfo.androidInfo;
                        if (_loginFormKey.currentState!.validate()) {
                          loginProvider.doLogin(
                            _mobileController.text,
                            _passwordController.text,
                            androidInfo.brand,
                            Platform.isAndroid ? 'Android' : 'iOS',
                            '',
                          );
                        }
                      },
                    );
                  }
                },
              ),
              AppSpacer.p8(),
              TextButton(
                onPressed: () {Navigator.pushNamed(context, AppRoutes.register);},
                child: const Text(AppString.createAccount),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

