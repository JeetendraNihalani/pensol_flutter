import 'package:flutter/material.dart';
import 'package:pensol/app/modules/menus/updatePin/providers/update_pin_provider.dart';
import 'package:pensol/app/routes/route_names.dart';

import '../../../../../core/api/api_constant.dart';
import '../../../../constants/app_spacing.dart';
import '../../../../widgets/app_elevated_button.dart';
import '../../../../widgets/app_loading_widget.dart';
import '../../../../widgets/app_pin_field_widget.dart';
import '../../../../widgets/app_spacer.dart';
import 'package:provider/provider.dart';

import '../providers/forgotPin_provider.dart';

class ForgotPinNewPinScreen extends StatefulWidget {
  const ForgotPinNewPinScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPinNewPinScreen> createState() => _ForgotPinNewPinScreenState();
}

class _ForgotPinNewPinScreenState extends State<ForgotPinNewPinScreen> {
  @override
  Widget build(BuildContext context) {

    final updatePinProvider = context.read<UpdatePinProvider>();

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
                'Enter New Pin',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            AppSpacer.p48(),
            AppPinFieldWidget(
                onChanged: (pin) {
                  updatePinProvider.setnewPin(pin);
                },
            ),
            AppSpacer.p48(),
            AppPinFieldWidget(
              onChanged: (pin) {
                updatePinProvider.setConfirmPin(pin);
              },
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
                    'Set New Pin',
                    onTap: () async {
                      await updatePinProvider.updatePin();
                      if(updatePinProvider.updatePinModel?.statusCode == 200){
                        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
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
    );
  }
}
