import 'package:flutter/material.dart';
import 'package:pensol/app/routes/route_names.dart';
import 'package:provider/provider.dart';

import '../../../../../core/api/api_constant.dart';
import '../../../../constants/app_spacing.dart';
import '../../../../constants/app_string.dart';
import '../../../../widgets/app_elevated_button.dart';
import '../../../../widgets/app_loading_widget.dart';
import '../../../../widgets/app_pin_field_widget.dart';
import '../../../../widgets/app_spacer.dart';
import '../../forgotPassword/providers/forgotPin_provider.dart';

class RegisterOTPScreen extends StatefulWidget {
  const RegisterOTPScreen({Key? key}) : super(key: key);

  @override
  State<RegisterOTPScreen> createState() => _RegisterOTPScreenState();
}

class _RegisterOTPScreenState extends State<RegisterOTPScreen> {
  @override
  Widget build(BuildContext context) {

    final _forgotPinOtp = TextEditingController();
    final forgotPinProvider = context.read<ForgotPinProvider>();

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100.0,
              child: Text(
                'Enter OTP',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            AppSpacer.p48(),
            AppPinFieldWidget(
              maxLength: 6,
                pinBoxWidth: 35,
                pinBoxHeight: 45,
                controller: _forgotPinOtp,
                onChanged: (otp) {
                  forgotPinProvider.setOtp(otp);
                }),
            AppSpacer.p8(),
            AppSpacer.p32(),
            /// A widget that listens to the changes in the provider and rebuilds the widget.
            Consumer<ForgotPinProvider>(
              builder: (context, state, child) {
                if (state.appState == AppState.loading) {
                  return const AppLoadingWidget();
                } else {
                  return AppElevatedButton(
                    'Submit OTP',
                    onTap: () async {
                      forgotPinProvider.verifyOtp(context,AppRoutes.register);
                    },
                  );
                }
              },
            ),
            AppSpacer.p8(),
          ],
        ),
      ),
    );
  }
}
