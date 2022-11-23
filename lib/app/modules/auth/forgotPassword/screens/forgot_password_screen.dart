import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pensol/app/modules/auth/forgotPassword/providers/forgotPin_provider.dart';
import 'package:pensol/app/modules/menus/updatePin/providers/update_pin_provider.dart';
import 'package:pensol/app/routes/route_names.dart';
import 'package:pensol/core/utils/extensions/validation_extension.dart';
import 'package:provider/provider.dart';

import '../../../../../core/api/api_constant.dart';
import '../../../../constants/app_spacing.dart';
import '../../../../constants/app_string.dart';
import '../../../../widgets/app_elevated_button.dart';
import '../../../../widgets/app_loading_widget.dart';
import '../../../../widgets/app_spacer.dart';
import '../../../../widgets/app_text_field.dart';
import '../../login/providers/login_provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  /// form key to validate mobile
  final _forgotPasswordFormKey = GlobalKey<FormState>();

  /// text controller for mobile number
  final _mobileController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {});
  }


  @override
  Widget build(BuildContext context) {
    /// A way to access the provider from the context.
    final forgotPinProvider = context.read<ForgotPinProvider>();
    final updatePinProvider = context.read<UpdatePinProvider>();
    return Scaffold(
      body: Form(
        key: _forgotPasswordFormKey,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100.0,
                child: Text(
                  AppString.forgotPin,
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
              AppSpacer.p32(),
              /// A widget that listens to the changes in the provider and rebuilds the widget.
              Consumer<ForgotPinProvider>(
                builder: (context, state, child) {
                  if (state.appState == AppState.loading) {
                    return const AppLoadingWidget();
                  } else {
                    return AppElevatedButton(
                      AppString.forgotPin,
                      onTap: () async {
                        await forgotPinProvider.checkUserRegister(_mobileController.text);
                        var userId = forgotPinProvider.checkUserRegisterModel?.result?.first.iUserId ?? 0;
                        if(userId != 0 && userId != null){
                          updatePinProvider.setUserID(userId);
                          forgotPinProvider.sendOTP(_mobileController.text,context,AppRoutes.forgotPinOtp);
                        }
                      },
                    );
                  }
                },
              ),
              AppSpacer.p8(),
              TextButton(
                onPressed: () {Navigator.pushNamed(context,  AppRoutes.registerMobileScreen);},
                child: const Text(AppString.createAccount),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
