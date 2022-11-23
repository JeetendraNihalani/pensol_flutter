import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../../app/modules/menus/couponHistory/providers/coupon_history_provider.dart';
import '../../../../../app/modules/menus/couponHistory/widgets/coupon_history_card.dart';
import '../../../../../app/widgets/app_base_screen.dart';
import '../../../../../app/widgets/app_loading_widget.dart';
import '../../../../../core/api/api_constant.dart';
import '../../../../../app/widgets/app_spacer.dart';
import '../../../../../app/widgets/user_info_card.dart';
import 'package:lottie/lottie.dart';

/// This class is a stateful widget that creates a screen that displays a list of coupons that the user
/// has used.
class CouponHistoryScreen extends StatefulWidget {
  const CouponHistoryScreen({Key? key}) : super(key: key);

  @override
  State<CouponHistoryScreen> createState() => _CouponHistoryScreenState();
}

class _CouponHistoryScreenState extends State<CouponHistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CouponHistoryProvider>().getCouponHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBaseScreen(
      title: 'Coupon History',
      child: Consumer<CouponHistoryProvider>(
        builder: (context, couponHistory, child) {
          if (couponHistory.appState == AppState.loading) {
            return const AppLoadingWidget();
          }
          if (couponHistory.appState == AppState.loaded) {
            if (couponHistory.couponHistory.couponHistoryResult?.length !=
                null) {
              final _couponHistory = couponHistory.couponHistory;
              return ListView.builder(
                itemCount: _couponHistory.couponHistoryResult?.length,
                itemBuilder: (context, index) {
                  final couponHistory =
                  _couponHistory.couponHistoryResult?[index];
                  final parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss")
                      .parse(couponHistory?.dModifiedOn ?? '');
                  final inputDate = DateTime.parse(parseDate.toString());
                  final outputFormat = DateFormat('dd-MMM-yyyy  HH:mm');
                  final couponDate = outputFormat.format(inputDate);
                  return CouponsHistoryCard(
                    leading: '${couponHistory?.redeemedPoint ?? ''}\nPoints',
                    subtitle: couponDate,
                    title: '${couponHistory?.vSINo}',
                  );
                },
              );
            }
            else{
              return Center(child: Lottie.asset('assets/lottie/no_data_found.json'));
            }
          }
          else{
            return Center(child: Lottie.asset('assets/lottie/error.json'));
          }

        },
      ),
      onRefresh: ()async{
      /// Calling the `getCouponHistory` method in the `CouponHistoryProvider` class.
      context.read<CouponHistoryProvider>().getCouponHistory();

      },
    );
  }
}
