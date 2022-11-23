import 'package:flutter/material.dart';
import 'package:pensol/app/modules/menus/updatePin/providers/update_pin_provider.dart';
import 'package:pensol/app/widgets/app_base_screen.dart';
import 'package:pensol/app/widgets/app_elevated_button.dart';
import 'package:pensol/app/widgets/app_loading_widget.dart';
import 'package:pensol/app/widgets/app_pin_field_widget.dart';
import 'package:pensol/core/api/api_constant.dart';
import 'package:provider/provider.dart';
import '../../../../../../app/widgets/app_spacer.dart';
import '../../../../../../app/widgets/user_info_card.dart';
import '../../../../../core/services/auth_service.dart';
import '../../../auth/login/domain/models/auth_model.dart';

class UpdatePinScreen extends StatelessWidget {
  const UpdatePinScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final updatePinProvider = context.read<UpdatePinProvider>();

    /// old pin controller
    /// Creating a TextEditingController object and assigning it to the variable _oldPinController.
    final _oldPinController = TextEditingController();

    /// new pin controller
   /// Creating a TextEditingController object and assigning it to the variable _newPinController.
    final _newPinController = TextEditingController();

    /// confirm pin controller
    /// Creating a TextEditingController object and assigning it to the variable _confirmPinController.
    final _confirmPinController = TextEditingController();

    return AppBaseScreen(
      title: 'Update Pin',
      child: ListView(
        children: [
          const UserPointInfo(),
          AppSpacer.p16(),
          Center(child: const Text('Old Pin *')),
          AppSpacer.p8(),
          AppPinFieldWidget(
            controller: _oldPinController,
            onChanged: (oldPin) {
              updatePinProvider.setOldPin(oldPin);
            },
          ),
          AppSpacer.p16(),
          Center(child: const Text('New Pin *')),
          AppSpacer.p8(),
          AppPinFieldWidget(
              controller: _newPinController,
              onChanged: (newPin) {
                updatePinProvider.setnewPin(newPin);
              }),
          AppSpacer.p16(),
          Center(child: const Text('Confirm Pin *')),
          AppSpacer.p8(),
          AppPinFieldWidget(
              controller: _confirmPinController,
              onChanged: (confirmPin) {
                updatePinProvider.setConfirmPin(confirmPin);
              }),
          const Spacer(),
          AppSpacer.p48(),
          /// A widget that rebuilds its child whenever the specified model changes.
          Consumer<UpdatePinProvider>(
            builder: (context, updatePin, child) {
              if (updatePin.buttonState == AppState.loading) {
                return const AppLoadingWidget();
              }
              return AppElevatedButton(
                'Update',
                onTap: () async{
                  AuthModel userDetails = await AuthService().userDetails();
                  updatePinProvider.setUserID(userDetails.result?[0].iUserId.toString());
                  updatePinProvider.updatePin();
                }
              );
            },
          ),

          AppSpacer.p16(),
        ],
      ),
    );
  }
}
