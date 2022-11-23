import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:pensol/app/constants/app_spacing.dart';
import '../../../../../core/utils/extensions/screen_extension.dart';

class GiftStatusCard extends StatelessWidget {
  const GiftStatusCard({
    Key? key,
    this.giftName,
    this.redeemedPoints,
    this.date,
    this.image,
    this.giftQty,
    this.currentStatus,
  }) : super(key: key);

  /// string gift name
  final String? giftName;

  /// string redeemed points
  final String? redeemedPoints;

  /// string date
  final String? date;

  /// string number of gifts
  final String? giftQty;

  /// string image url
  final String? image;

  /// int current active step
  final int? currentStatus;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: context.width,
      child: Card(
        margin: const EdgeInsets.all(AppSpacing.sm),
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.md,
            horizontal: AppSpacing.xs,
          ),
          child: Column(
            children: [
              ListTile(
                  leading: const Material(
                    elevation: 5.0,
                    shape: CircleBorder(),
                    child: CircleAvatar(
                      radius: 40.0,
                      backgroundImage:
                          NetworkImage('https://picsum.photos/200'),
                    ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      richTextWidget("Gift: ", giftName ?? ''),
                      richTextWidget("Redeemed Points: ", redeemedPoints ?? ''),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      richTextWidget("Claim Date: ", date ?? ''),
                      richTextWidget("No. of Gift: ", giftQty ?? ''),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconStepper(
                  icons: const [
                    Icon(Icons.person),
                    Icon(Icons.approval),
                    Icon(Icons.local_shipping),
                    Icon(Icons.all_inbox),
                  ],
                  direction: Axis.horizontal,
                  enableStepTapping: false,
                  enableNextPreviousButtons: false,
                  stepRadius: 18,
                  activeStep: currentStatus ?? 0,

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget richTextWidget(String key, String value) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(text: key),
          TextSpan(text: value),
        ],
      ),
    );
  }
}
