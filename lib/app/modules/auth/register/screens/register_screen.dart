import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pensol/core/utils/extensions/validation_extension.dart';
import 'package:provider/provider.dart';

import '../../../../../core/api/api_constant.dart';
import '../../../../constants/app_spacing.dart';
import '../../../../constants/app_string.dart';
import '../../../../routes/route_names.dart';
import '../../../../widgets/app_elevated_button.dart';
import '../../../../widgets/app_loading_widget.dart';
import '../../../../widgets/app_pin_field_widget.dart';
import '../../../../widgets/app_spacer.dart';
import '../../../../widgets/app_text_field.dart';
import '../providers/register_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  String token = "";
  /// form key to validate mobile and password
  final _registerFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    generateFirebaseToken();
  }

  generateFirebaseToken() async {
    token = (await firebaseMessaging.getToken())!;
  }

  @override
  Widget build(BuildContext context) {
    final registerProvider = context.read<RegisterProvider>();
    return Scaffold(
      body: Form(
        key : _registerFormKey,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppSpacer.p48(),
                SizedBox(
                  height: 60.0,
                  child: Center(
                    child: Text(
                      AppString.register,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
                AppSpacer.p48(),
                AppTextField(
                  hintText: AppString.name,
                  inputFormatter: [
                    FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z]'))
                  ],
                  onChanged: (name) {
                    registerProvider.setName(name);
                  },
                  validator: (mobile) => mobile!.isTextValid(),
                ),
                AppSpacer.p8(),
                AppTextField(
                  hintText: AppString.workshop,
                  inputFormatter: [
                    FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z]'))
                  ],
                  onChanged: (Workshop) {
                    registerProvider.setWorkshop(Workshop);
                  },
                  validator: (mobile) => mobile!.isTextValid(),
                ),
                AppSpacer.p8(),
                AppTextField(
                  hintText: AppString.roadName,
                  inputFormatter: [
                    FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z]'))
                  ],
                  onChanged: (RoadName) {
                    registerProvider.setRoadName(RoadName);
                  },
                  validator: (mobile) => mobile!.isTextValid(),
                ),
                AppSpacer.p8(),
                AppTextField(
                  maxLength: 6,
                  hintText: AppString.pincode,
                  keyboardType: TextInputType.number,
                  inputFormatter: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                  onChanged: (Pincode) {
                    registerProvider.setPincode(Pincode);
                  },
                  validator: (mobile) => mobile!.isPincodeValid(),
                ),
                AppSpacer.p8(),
                AppTextField(
                  hintText: AppString.city,
                  inputFormatter: [
                    FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]'))
                  ],
                  onChanged: (City) {
                    registerProvider.setCity(City);
                  },
                ),
                AppSpacer.p8(),
                AppTextField(
                  hintText: AppString.state,
                  inputFormatter: [
                    FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]'))
                  ],
                  onChanged: (State) {
                    registerProvider.setState(State);
                  },
                ),
                AppSpacer.p8(),
                AppTextField(
                  maxLength: 10,
                  hintText: AppString.mobileHint,
                  keyboardType: TextInputType.phone,
                  inputFormatter: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                  validator: (mobile) => mobile!.isMobileValid(),
                  onChanged: (MobileNumber) {
                    registerProvider.setMobileNumber(MobileNumber);
                  },
                ),
                AppSpacer.p16(),
                Center(child: const Text('New Pin *')),
                AppSpacer.p16(),
                AppPinFieldWidget(
                  onChanged: (pin) {
                    registerProvider.setnewPin(pin);
                  },
                ),
                AppSpacer.p8(),
                AppTextField(
                  maxLength: 12,
                  hintText: AppString.adharNumber,
                  keyboardType: TextInputType.number,
                  inputFormatter: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                  onChanged: (AadharNumber) {
                    registerProvider.setAadharNumber(AadharNumber);
                  },
                  validator: (mobile) => mobile!.isAadharValid(),
                ),
                AppSpacer.p8(),
                AppTextField(
                  hintText: AppString.distributer,
                  inputFormatter: [
                    FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z]'))
                  ],
                  onChanged: (DistributorName) {
                    registerProvider.setDistributorName(DistributorName);
                  },
                  validator: (mobile) => mobile!.isTextValid(),
                ),
                AppSpacer.p8(),
                AppTextField(
                  hintText: AppString.pensolSalePerson,
                  inputFormatter: [
                    FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z]'))
                  ],
                  onChanged: (PensolSalePerson) {
                    registerProvider.setPensolSalePerson(PensolSalePerson);
                  },
                  validator: (mobile) => mobile!.isTextValid(),
                ),
                AppSpacer.p8(),
                /// A widget that listens to the changes in the provider and rebuilds the widget.
                Consumer<RegisterProvider>(
                  builder: (context, state, child) {
                    if (state.appState == AppState.loading) {
                      return const AppLoadingWidget();
                    } else {
                      return AppElevatedButton(
                        AppString.register,
                        onTap: () async {
                            if (_registerFormKey.currentState!.validate()) {
                              await registerProvider.register(token);
                            }
                          }
                      );
                    }
                  },
                ),
                AppSpacer.p8(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
