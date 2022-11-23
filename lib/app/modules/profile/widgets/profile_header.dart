import 'package:flutter/material.dart';
import '../../../../app/constants/app_spacing.dart';
import '../../../../app/modules/home/providers/home_provider.dart';
import '../../../../app/widgets/app_spacer.dart';
import 'package:provider/provider.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: AppSpacing.xl),
            color: Theme.of(context).colorScheme.secondary,

      height: 240.0,
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
              top: AppSpacing.xl,
              left: AppSpacing.xl,
              right: AppSpacing.xl,
              bottom: AppSpacing.md,
            ),
            child: Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
              ),
              elevation: 5.0,
              child: Column(
                children: <Widget>[
                  AppSpacer.p48(),
                  AppSpacer.p8(),
                  Consumer<HomeProvider>(
                    builder: (context, user, child) {
                      final firstName = user.userDetails.result?[0].vFirstName;
                      final lastName = user.userDetails.result?[0].vFirstName;
                      return Text(
                        '$firstName \n$lastName',
                        style: Theme.of(context).textTheme.subtitle1,
                      );
                    },
                  ),
                  AppSpacer.p4(),
                  Consumer<HomeProvider>(
                    builder: (context, user, child) {
                      final shopName = user.userDetails.result?[0].shopName;

                      return Text(
                        '$shopName',
                        style: Theme.of(context).textTheme.caption,
                      );
                    },
                  ),
                  AppSpacer.p16(),
                  SizedBox(
                    height: 40.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Consumer<HomeProvider>(
                            builder: (context, user, child) {
                              final availablePoints =
                                  user.userAvailablePoints;

                              return ListTile(
                                title: Text(
                                  availablePoints.toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text("Earned Points".toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 12.0,color: Colors.black)),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: Consumer<HomeProvider>(
                            builder: (context, user, child) {
                              final nearestGift =
                                  user.userDetails.result?[0].vNearestGiftName;

                              return ListTile(
                                title: Text(
                                  nearestGift.toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text("Next Gift".toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 12.0,color: Colors.black)),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Material(
              elevation: 5.0,
              shape: CircleBorder(),
              child: Consumer<HomeProvider>(
                builder: (context, user, child) {
                  final userImage = user.userDetails.result?[0].profilePic;
                  return CircleAvatar(
                    radius: 40.0,
                    backgroundImage: NetworkImage(userImage ?? 'https://picsum.photos/200'),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
