import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pensol/app/widgets/dialogs/app_dialog.dart';
import 'package:pensol/core/utils/extensions/validation_extension.dart';
import 'package:provider/provider.dart';

import '../../../../../core/api/api_constant.dart';
import '../../../../constants/app_spacing.dart';
import '../../../../constants/app_string.dart';
import '../../../../routes/route_names.dart';
import '../../../../widgets/app_elevated_button.dart';
import '../../../../widgets/app_loading_widget.dart';
import '../../../../widgets/app_spacer.dart';
import '../../../../widgets/app_text_field.dart';
import '../../forgotPassword/providers/forgotPin_provider.dart';

class RegisterMobileNumberScreen extends StatefulWidget {
  const RegisterMobileNumberScreen({Key? key}) : super(key: key);

  @override
  State<RegisterMobileNumberScreen> createState() => _RegisterMobileNumberScreenState();
}

class _RegisterMobileNumberScreenState extends State<RegisterMobileNumberScreen> {

  /// text controller for mobile number
  final _mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final forgotPinProvider = context.read<ForgotPinProvider>();
    return Scaffold(
      body: Form(
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100.0,
                child: Text(
                  AppString.register,
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
                      AppString.register,
                      onTap: () async {
                        await forgotPinProvider.checkUserRegister(_mobileController.text);
                        var userId = forgotPinProvider.checkUserRegisterModel?.result?.first.iUserId ?? 0;
                        if(userId == null) {
                          forgotPinProvider.sendOTP(_mobileController.text,context,AppRoutes.registerOTPScreen);
                        }
                        else{
                          AppDialog().error(context, 'Error', 'This User Is alrefy registered With Us!!\nPlease Login', Colors.red);
                        }
                      },
                    );
                  }
                },
              ),
              AppSpacer.p8(),
            ],
          ),
        ),
      ),
    );
  }
}
