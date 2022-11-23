import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pensol/app/themes/theme_notifier.dart';
import 'package:provider/provider.dart';

import 'app/modules/auth/forgotPassword/providers/forgotPin_provider.dart';
import 'app/modules/auth/login/providers/login_provider.dart';
import 'app/modules/auth/register/providers/register_provider.dart';
import 'app/modules/home/providers/home_provider.dart';
import 'app/modules/menus/claimGift/providers/claim_gift_provider.dart';
import 'app/modules/menus/couponHistory/providers/coupon_history_provider.dart';
import 'app/modules/menus/giftCollection/providers/gift_collection_provider.dart';
import 'app/modules/menus/giftStatus/providers/gift_status_provider.dart';
import 'app/modules/menus/manualCouponEntry/providers/manual_coupon_code_provider.dart';
import 'app/modules/menus/notification/providers/notification_provider.dart';
import 'app/modules/menus/updatePin/providers/update_pin_provider.dart';
import 'app/modules/splash/splash_page.dart';
import 'app/routes/route_generator.dart';
import 'app/routes/route_names.dart';
import 'app/themes/dark_theme.dart';
import 'app/themes/light_theme.dart';
import 'flavors.dart';

/// Used to access the navigator from anywhere in the app.
final GlobalKey<NavigatorState> navigatorKey = GlobalKey();


class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        /// A provider that is used to provide the data to the widgets.
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
        ChangeNotifierProvider(create: (_) => ForgotPinProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => ClaimGiftProvider()),
        ChangeNotifierProvider(create: (_) => CouponHistoryProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => GiftStatusProvider()),
        ChangeNotifierProvider(create: (_) => GiftCollectionProvider()),
        ChangeNotifierProvider(create: (_) => UpdatePinProvider()),
        ChangeNotifierProvider(create: (_) => ManualCouponCodeProvider()),
        ChangeNotifierProvider(create: (_) => ThemeChanger()),
      ],
      child: Consumer<ThemeChanger>(
        builder: (BuildContext context, value, child) {
          return MaterialApp(
            title: 'Pensol',
            theme: value.darkTheme ? darkTheme : lightTheme,
            navigatorKey: navigatorKey,
            initialRoute: getIntialPage(),
            onGenerateRoute: RouteGenerator.generateRoute,

            /// The initial page of the app.
            home: const SplashPage(),
          );
        },
      ),
    );
  }

  String getIntialPage() => AppRoutes.splash;

  Widget _flavorBanner({
    required Widget child,
    bool show = true,
  }) =>
      show
          ? Banner(
              location: BannerLocation.topStart,
              message: F.name,
              color: Colors.green.withOpacity(0.6),
              textStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12.0,
                letterSpacing: 1.0,
              ),
              textDirection: TextDirection.ltr,
              child: child,
            )
          : child;

}
