import 'package:flutter/material.dart';
import 'package:pensol/app/constants/app_spacing.dart';
import 'package:pensol/app/widgets/app_spacer.dart';

/// This class is a stateless widget that displays a card with a coupon's information.
class CouponsHistoryCard extends StatelessWidget {
  const CouponsHistoryCard({
    Key? key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.isCouponSelected = false,
    this.onCardPressed,
  }) : super(key: key);

  /// string to display leading text
  final String? leading;

  /// string to display title text
  final String? title;

  /// string to display subtitle text
  final String? subtitle;

  /// widget to display trailing text
  final Widget? trailing;

  /// bool for checking the selected coupon
  final bool isCouponSelected;

  /// function on pressed
  final Function()? onCardPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCardPressed,
      child: Container(
        margin: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSpacing.xs),
        ),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              margin: const EdgeInsets.only(right: AppSpacing.md),
              alignment: Alignment.center,
              child: Text(
                leading ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              decoration: BoxDecoration(
                border: isCouponSelected
                    ? Border.all(
                        color: Theme.of(context).textTheme.bodyText1!.color!,
                        width: 2,
                      )
                    : null,
                color:
                    Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(2),
                  bottomLeft: Radius.circular(2),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      
                    ),
                  ),
                  Text(
                    subtitle ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            AppSpacer.p16(),
            trailing ?? const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
