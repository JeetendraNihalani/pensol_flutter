import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../../../app/modules/menus/giftStatus/providers/gift_status_provider.dart';
import '../../../../../app/modules/menus/giftStatus/widgets/gift_status_card.dart';
import '../../../../../app/widgets/app_base_screen.dart';
import '../../../../../app/widgets/app_loading_widget.dart';
import '../../../../../core/api/api_constant.dart';
import '../../../../../app/widgets/app_spacer.dart';
import '../../../../../app/widgets/user_info_card.dart';

class GiftStatusScreen extends StatefulWidget {
  const GiftStatusScreen({Key? key}) : super(key: key);

  @override
  State<GiftStatusScreen> createState() => _GiftStatusScreenState();
}

class _GiftStatusScreenState extends State<GiftStatusScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<GiftStatusProvider>().getGiftStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBaseScreen(
      title: 'Gift Status',
      child: Column(
        children: [
          const UserPointInfo(),
          AppSpacer.p16(),
          Expanded(
            child: Consumer<GiftStatusProvider>(
              builder: (context, giftStatus, child) {
                final giftStatusList = giftStatus.giftStatus.giftStatusResult;
                final giftStatusCount = giftStatusList?.length;

                if (giftStatus.appState == AppState.loading) {
                  return const AppLoadingWidget();
                }
                if (giftStatus.appState == AppState.loaded) {
                  if (giftStatusCount != null) {
                    return ListView.builder(
                      itemCount: giftStatusCount,
                      itemBuilder: (context, index) {
                        final giftStatus = giftStatusList?[index];

                        return GiftStatusCard(
                          giftName: giftStatus?.giftName,
                          redeemedPoints: giftStatus?.giftPoint.toString(),
                          giftQty: giftStatus?.giftQty.toString(),
                          date: giftStatus?.claimDate.toString(),
                          currentStatus: getGiftStatus(giftStatus?.claimStatus ?? 'A'),
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
          )
        ],
      ),
      onRefresh: () async {
        context.read<GiftStatusProvider>().getGiftStatus();
      },
    );
  }

  int getGiftStatus(String currentStatus) {
    switch (currentStatus) {
      case 'A':
        return 0;
      case 'H':
        return 1;
      case 'W':
        return 2;
      case 'D':
        return 3;
      default:
        return 0;
    }
  }
}
