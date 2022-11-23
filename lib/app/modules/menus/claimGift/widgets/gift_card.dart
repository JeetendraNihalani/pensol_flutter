import 'package:flutter/material.dart';
import 'package:pensol/app/modules/home/providers/home_provider.dart';
import 'package:provider/provider.dart';
import '../../../../../../app/constants/app_spacing.dart';
import '../../../../../../app/constants/app_string.dart';
import '../../../../../../app/widgets/app_elevated_button.dart';
import '../../../../../../app/widgets/app_quantity_widget.dart';
import '../../../../../../app/widgets/app_spacer.dart';
import '../providers/claim_gift_provider.dart';

/// This class is a stateless widget that displays a gift card.
class GiftCard extends StatelessWidget {
  const GiftCard({
    Key? key,
    this.productImage,
    this.productName,
    this.productId,
    required this.requirePoints,
    this.onCLaim,
    this.quantity,
    this.onQtyIncrement,
    this.onQtyDecrement,
  }) : super(key: key);

  ///  string product image
  final String? productImage;

  ///  string product name
  final String? productName;

  ///  string product name
  final double? productId;

  ///  string required points
  final double requirePoints;

  /// function on CLaim
  final Function()? onCLaim;

  /// function onQtyChanged
  final Function()? onQtyIncrement;

  /// function onQtyChanged
  final Function()? onQtyDecrement;

  /// int quantity
  final int? quantity;
  @override
  Widget build(BuildContext context) {
    /// Getting the text theme from the context.
    final theme = Theme.of(context).textTheme;
    final claimGiftProvider = context.read<ClaimGiftProvider>();
    return SizedBox(
      width: double.infinity,
      height: 160,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              // Image.asset(productImage ?? AppImages.scan),
              AppSpacer.p16(),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productName ?? 'N.A',
                                style: theme.titleSmall
                                    ?.copyWith(overflow: TextOverflow.ellipsis),
                              ),
                              AppSpacer.p16(),
                              Text(
                                'Required Points: ${requirePoints ?? 'N.A'}',
                                style: theme.subtitle1,
                              ),
                              AppSpacer.p8(),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                            child: Image.network(productImage ?? 'https://img.lovepik.com/free-png/20211211/lovepik-gift-icon-free-vector-illustration-material-png-image_401492602_wh1200.png'),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppQuantityWidget(
                          onQtyIncrement: onQtyIncrement,
                          onQtyDecrement: onQtyDecrement,
                          qty: quantity,
                        ),
                        Consumer<HomeProvider>(
                          builder: (context, home, child) {
                            final _availablePoints = double.tryParse(
                                home.userAvailablePoints ?? '0') ??
                                0.0;
                            final _nearestGiftPoints = double.tryParse(
                                home.userRequiredPoints ?? '0') ??
                                0.0;
                            final claimable =
                                _availablePoints >= requirePoints;
                            return AppElevatedButton(
                              AppString.claim,
                              width: 100,
                              height: 40,
                              backgroundColor: MaterialStateProperty.resolveWith((states) {
                                if (claimable) {
                                  return Theme.of(context).colorScheme.onSurface;
                                }
                                return Colors.grey.withAlpha(1);
                              }),
                              onTap: () {
                                if (claimable) {
                                  claimGiftProvider.redeemGift(productId!.toInt().toString(),home.userDetails.result?.first.iUserId.toString() ?? "");
                                }
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
