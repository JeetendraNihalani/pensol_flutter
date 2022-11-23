import 'package:flutter/material.dart';
import '../../app/widgets/app_spacer.dart';

class AppNoData extends StatelessWidget {
  const AppNoData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Image.asset(AppImages.noData),
        AppSpacer.p16(),
        // const Text(AppStrings.noData)
      ],
    );
  }
}
