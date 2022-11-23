import 'package:flutter/material.dart';
import '../../../app/modules/profile/widgets/profile_header.dart';
import '../../../app/modules/profile/widgets/user_info.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          Container(
            height: 200.0,
            color: Theme.of(context).colorScheme.secondary,
          ),
          ListView(
            children: const [
              ProfileHeader(),
              UserInfo(),
            ],
          )
        ],
      ),
    );
  }
}
