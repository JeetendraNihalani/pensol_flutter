import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:pensol/app/modules/home/providers/home_provider.dart';
import 'package:provider/provider.dart';
import '../../app/constants/app_spacing.dart';
import '../../app/constants/app_string.dart';
import '../../app/widgets/app_spacer.dart';

/// This class is a stateless widget that displays the user's current points and the user's current
/// level.
class UserPointInfo extends StatelessWidget {
  const UserPointInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return SizedBox(
      width: double.infinity,
      height: 170,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(AppString.availablePoints),
              AppSpacer.p4(),
              Consumer<HomeProvider>(
                builder: (context, user, child) {
                  final _availablePoints = user.userAvailablePoints;
                  return Text(
                    _availablePoints ?? '',
                    style: theme.headline5?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
              AppSpacer.p8(),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 10,
                      child: RepaintBoundary(
                        child: Consumer<HomeProvider>(
                          builder: (context, user, child) {
                            final availablePoints = double.tryParse(
                                user.userAvailablePoints ?? '0');
                            final nearestGiftPoints =
                                double.tryParse(user.userRequiredPoints ?? '0');
                            final achievedPercentage =
                                availablePoints ?? 0 / nearestGiftPoints!;


                            return LiquidLinearProgressIndicator(
                              value: achievedPercentage, // Defaults to 0.5.
                              valueColor: AlwaysStoppedAnimation(
                                Theme.of(context).primaryColor,
                              ),
                              backgroundColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.3),
                              direction: Axis.horizontal,
                              center: const Text(''),
                              borderRadius: AppSpacing.md,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  AppSpacer.p8(),
                  const Icon(Icons.insert_chart)
                ],
              ),
              AppSpacer.p8(),
              Consumer<HomeProvider>(
                builder: (context, user, child) {
                  final requiredPoints = user.userRequiredPoints;
                  final nearestGift = user.userNearestGift;
                  return Text(
                      '$requiredPoints Points to $nearestGift',
                      maxLines: 1,
                      style: theme.caption,);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
