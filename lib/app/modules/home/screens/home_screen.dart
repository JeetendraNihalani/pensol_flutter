import 'package:flutter/material.dart';
import 'package:pensol/app/modules/home/providers/home_provider.dart';
import 'package:pensol/app/widgets/app_base_screen.dart';
import 'package:pensol/app/widgets/app_spacer.dart';
import 'package:pensol/core/api/api_constant.dart';
import 'package:provider/provider.dart';
import '../../../../../../app/constants/app_string.dart';
import '../../../../../../app/modules/home/widgets/menu_widget.dart';
import '../../../../../../app/widgets/user_info_card.dart';

/// This class is a stateless widget that is the home screen of the app
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<HomeProvider>().getMobileSettings();
    });
  }

  @override
  Widget build(BuildContext context) {
    /// Calling the method `getUserDetails` from the provider `HomeProvider`
    context.read<HomeProvider>().getUserDetails();
    final provider = context.watch<HomeProvider>();
    return AppBaseScreen(
      title: AppString.appName,
      showFab: true,
      child: Column(
        children: [
          // if (provider.appState == AppState.loaded) ...[
            const UserPointInfo(),
          // ],
          AppSpacer.p24(),
          const Menus(),
        ],
      ),
      onRefresh: () async {
        context.read<HomeProvider>().getMobileSettings();
      },
    );
  }
}
