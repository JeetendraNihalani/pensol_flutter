import 'package:flutter/material.dart';
import 'package:pensol/app/themes/theme_notifier.dart';
import '../../../../app/modules/home/providers/home_provider.dart';
import 'package:provider/provider.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeChanger>();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Consumer<HomeProvider>(
        builder: (context, user, child) {
          final userMail = user.userDetails.result?[0].vEmailId;
          final phone = user.userDetails.result?[0].iMobileNo;
          final address = user.userDetails.result?[0].roadName;
          final dsrName = user.userDetails.result?[0].dsrName;
          return Column(
            children: <Widget>[
              const ListTile(
                title: Text("User information"),
              ),
              const Divider(),
              ListTile(
                title: const Text("Email"),
                subtitle: Text(userMail ?? '-'),
                leading: const Icon(Icons.email),
              ),
              ListTile(
                title: const Text("Phone"),
                subtitle: Text(phone ?? '-'),
                leading: const Icon(Icons.phone),
              ),
              ListTile(
                title: const Text("DSR Name"),
                subtitle: Text(dsrName ?? '-'),
                leading: const Icon(Icons.web),
              ),
              ListTile(
                title: const Text("Address"),
                subtitle: Text(address ?? '-'),
                leading: const Icon(Icons.person),
              ),
              ListTile(
                title: const Text("Theme"),
                leading: Icon(
                  themeProvider.darkTheme ? Icons.dark_mode : Icons.light_mode,
                ),
                trailing: Switch.adaptive(
                  value: themeProvider.darkTheme,
                  onChanged: (value) {
                    themeProvider.darkTheme = value;
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
