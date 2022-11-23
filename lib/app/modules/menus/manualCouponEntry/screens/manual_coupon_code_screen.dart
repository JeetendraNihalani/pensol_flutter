import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../../../app/modules/menus/manualCouponEntry/providers/manual_coupon_code_provider.dart';
import '../../../../../app/widgets/app_base_screen.dart';
import '../../../../../app/widgets/app_elevated_button.dart';
import '../../../../../app/widgets/app_loading_widget.dart';
import '../../../../../app/widgets/app_text_field.dart';
import '../../../../../core/api/api_constant.dart';
import '../../../../../core/utils/extensions/validation_extension.dart';
import '../../../../../app/widgets/app_spacer.dart';
import '../../../../../app/widgets/user_info_card.dart';

class ManualCouponCodeScreen extends StatelessWidget {
  const ManualCouponCodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// form key to validate coupon code
    final _codeFormKey = GlobalKey<FormState>();

    /// Text editing controller for coupon code
    final couponCodeController = TextEditingController();

    return AppBaseScreen(
      title: 'Redeem Coupon',
      child: Form(
        key: _codeFormKey,
        child: Column(
          children: [
            UserPointInfo(),
            AppSpacer.p16(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppTextField(
                controller: couponCodeController,
                hintText: 'Enter 16 digit coupon code',
                prefixIcon: Icons.qr_code,
                maxLength: 16,
                validator: (code) => code!.isCouponCodeValid(),
                inputFormatter: [
                  FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]'))
                ],
              ),
            ),
            const Spacer(),
            Consumer<ManualCouponCodeProvider>(
              builder: (context, couponCode, child) {
                if (couponCode.buttonState == AppState.loading) {
                  return const AppLoadingWidget();
                }
                return AppElevatedButton(
                  'Claim',
                  onTap: () {
                    if (_codeFormKey.currentState!.validate()) {
                      couponCode.redeemCoupon(
                        couponCodeController.text.trim(),
                      );
                    }
                  },
                );
              },
            ),
            AppSpacer.p48(),
            AppSpacer.p24(),
          ],
        ),
      ),
    );
  }
}
