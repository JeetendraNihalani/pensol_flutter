import 'package:flutter/material.dart';
import 'package:pensol/app/widgets/dialogs/app_dialog.dart';
import '../../../../../../app/constants/app_spacing.dart';
import '../../../../../../app/routes/route_names.dart';
import '../../../../../../app/widgets/app_spacer.dart';

import '../../../../app.dart';


/// This class is a stateless widget that creates a list of menu items for the dashboard
class DashboardMenus extends StatelessWidget {
  const DashboardMenus._({
    Key? key,
    this.color,
    this.icon,
    required this.title,
    this.onTap,
  }) : super(key: key);

  /// background color of card
  final Color? color;

  /// icondata icon
  final IconData? icon;

  /// string title
  final String title;

  /// function ontap
  final Function()? onTap;

  /// A factory constructor.
  factory DashboardMenus.claimGift() => DashboardMenus._(
        title: 'Claim Gift',
        color: Colors.pink,
        icon: Icons.explore_outlined,
        onTap: () => navigatorKey.currentState?.pushNamed(AppRoutes.claimGift),
      );

  factory DashboardMenus.giftStatus() => DashboardMenus._(
        title: 'Gift Status',
        color: Colors.purple,
        icon: Icons.fact_check_outlined,
        onTap: () => navigatorKey.currentState?.pushNamed(AppRoutes.giftStatus),
      );

  factory DashboardMenus.couponHistory() => DashboardMenus._(
        title: 'Coupons\nHistory',
        color: Colors.orange,
        icon: Icons.history_outlined,
        onTap: () =>
            navigatorKey.currentState?.pushNamed(AppRoutes.couponHistory),
      );
  factory DashboardMenus.giftCollection() => DashboardMenus._(
        title: 'Gift\nCollection',
        color: Colors.green,
        icon: Icons.card_giftcard_outlined,
        onTap: () =>
            navigatorKey.currentState?.pushNamed(AppRoutes.giftCollection),
      );
  factory DashboardMenus.enterCode() => DashboardMenus._(
        title: 'Enter Code',
        color: Colors.purple,
        icon: Icons.code_outlined,
        onTap: () =>
            navigatorKey.currentState?.pushNamed(AppRoutes.manualCouponEntry),
      );

  factory DashboardMenus.updatePin() => DashboardMenus._(
        title: 'Update Pin',
        color: Colors.orange,
        icon: Icons.pin_outlined,
        onTap: () => navigatorKey.currentState?.pushNamed(AppRoutes.updatePin),
      );

  factory DashboardMenus.notification() => DashboardMenus._(
        title: 'Notification',
        color: Colors.green,
        icon: Icons.notifications_outlined,
        onTap: () =>
            navigatorKey.currentState?.pushNamed(AppRoutes.notification),
      );

  factory DashboardMenus.logout() => DashboardMenus._(
        title: 'Logout',
        color: Colors.pink,
        icon: Icons.power_settings_new,
        onTap: () => AppDialog().exitApp(navigatorKey.currentContext!),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: color?.withOpacity(0.2),
                borderRadius: const BorderRadius.all(
                  Radius.elliptical(180, 300),
                ),
              ),
              child: RotationTransition(
                turns: const AlwaysStoppedAnimation(15 / 360),
                child: Icon(
                  icon,
                  color: color,
                  size: AppSpacing.lg,
                ),
              ),
            ),
            AppSpacer.p16(),
            Text(
              title,
              style: Theme.of(context).textTheme.caption?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
