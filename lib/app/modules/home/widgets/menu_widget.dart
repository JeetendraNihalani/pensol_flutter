import 'package:flutter/material.dart';
import 'package:pensol/app/constants/app_spacing.dart';
import '../../../../../../app/modules/home/widgets/menu_card.dart';


/// This class is a stateless widget that creates a menu
class Menus extends StatelessWidget {
  const Menus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom:AppSpacing.xl),
        child:Wrap(
          spacing: AppSpacing.sm,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          alignment: WrapAlignment.spaceEvenly,
          children: [
            DashboardMenus.claimGift(),
            DashboardMenus.giftStatus(),
            DashboardMenus.couponHistory(),
            DashboardMenus.giftCollection(),
            DashboardMenus.enterCode(),
            DashboardMenus.updatePin(),
            DashboardMenus.notification(),
            DashboardMenus.logout(),
            
          ],
        ),
      ),
    );
  }
}


