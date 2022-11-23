import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../../../app/modules/menus/giftCollection/providers/gift_collection_provider.dart';
import '../../../../../app/modules/menus/giftCollection/widgets/gift_collection_card.dart';
import '../../../../../app/widgets/app_base_screen.dart';
import '../../../../../app/widgets/app_loading_widget.dart';
import '../../../../../core/api/api_constant.dart';
import '../../../../../app/widgets/app_spacer.dart';
import '../../../../../app/widgets/user_info_card.dart';

/// This class is a stateful widget that creates a stateful widget called GiftCollectionScreen
class GiftCollectionScreen extends StatefulWidget {
  const GiftCollectionScreen({Key? key}) : super(key: key);

  @override
  State<GiftCollectionScreen> createState() => _GiftCollectionScreenState();
}

class _GiftCollectionScreenState extends State<GiftCollectionScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<GiftCollectionProvider>().getGiftCollection();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBaseScreen(
      title: 'Gift Collection',
      child: Column(
        children: [
          const UserPointInfo(),
          AppSpacer.p16(),
          Expanded(
            child: Consumer<GiftCollectionProvider>(
              builder: (context, giftCollection, child) {
                if (giftCollection.appState == AppState.loading) {
                  return const AppLoadingWidget();
                }
                if (giftCollection.appState == AppState.loaded) {
                  if (giftCollection.giftCollection.giftCollectionResult?.length !=
                      null) {
                    final _giftCollection = giftCollection.giftCollection;
                    return ListView.builder(
                      itemCount: _giftCollection.giftCollectionResult?.length,
                      itemBuilder: (context, index) {
                        final giftCollection =
                        _giftCollection.giftCollectionResult?[index];
                        final parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss")
                            .parse(giftCollection?.startDate ?? '');
                        final inputDate = DateTime.parse(parseDate.toString());
                        final outputFormat = DateFormat('dd-MMM-yyyy');
                        final giftCollectionDate = outputFormat.format(inputDate);
                        return GiftCollectionCard(
                          index: index,
                          giftName: giftCollection?.giftName,
                          redeemedPoints:
                          giftCollection?.redeemablePoints.toString(),
                          giftQty: giftCollection?.giftQty.toString(),
                          claimDate: giftCollectionDate,
                          claimId: giftCollection?.giftId.toString(),
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
          ),
        ],
      ),
      onRefresh: ()async{
      context.read<GiftCollectionProvider>().getGiftCollection();

      },
    );
  }
}
