import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../../../app/modules/menus/claimGift/providers/claim_gift_provider.dart';
import '../../../../../app/widgets/app_base_screen.dart';
import '../../../../../app/widgets/app_loading_widget.dart';
import '../../../../../core/api/api_constant.dart';
import '../../../../../app/modules/menus/claimGift/widgets/gift_card.dart';
import '../../../../../app/widgets/app_spacer.dart';
import '../../../../../app/widgets/user_info_card.dart';

class ClaimGiftScreen extends StatefulWidget {
  const ClaimGiftScreen({Key? key}) : super(key: key);

  @override
  State<ClaimGiftScreen> createState() => _ClaimGiftScreenState();
}

class _ClaimGiftScreenState extends State<ClaimGiftScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ClaimGiftProvider>().getClaimGifts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBaseScreen(
      title: 'Claim Gift',
      child: Column(
        children: [
          const UserPointInfo(),
          AppSpacer.p16(),
          Expanded(
            child: Consumer<ClaimGiftProvider>(
              builder: (context, claimgiftList, child) {
                final claimGiftList =
                    claimgiftList.claimgiftList.claimGiftListResult;
                final claimGiftCount = claimGiftList?.length;

                if (claimgiftList.appState == AppState.loading) {
                  return const AppLoadingWidget();
                }
                if (claimgiftList.appState == AppState.loaded) {
                  if (claimGiftCount != null) {
                    return ListView.builder(
                      itemCount: claimGiftCount,
                      itemBuilder: (context, index) {
                        final claimGift = claimGiftList?[index];

                        var qty = claimGift?.giftQty ?? 1;

                        return GiftCard(
                          productId: claimGift?.giftId,
                          productName: claimGift?.giftName ?? '',
                          requirePoints:
                          claimGift?.redeemablePoints ?? 0,
                          quantity: qty,
                          onQtyDecrement: () {
                            if (qty > 1) {
                              claimgiftList.decrementQty(index, qty);
                            }
                          },
                          onQtyIncrement: () => claimgiftList.incrementQty(index, qty),
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
        context.read<ClaimGiftProvider>().getClaimGifts();
      },
    );
  }
}
