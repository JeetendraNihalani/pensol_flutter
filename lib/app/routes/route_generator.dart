import 'package:flutter/material.dart';
import 'package:pensol/app/modules/auth/forgotPassword/screens/forgotPin_newPin_screen.dart';
import 'package:pensol/app/modules/auth/forgotPassword/screens/forgotPin_otp_screen.dart';
import 'package:pensol/app/modules/auth/forgotPassword/screens/forgot_password_screen.dart';
import 'package:pensol/app/modules/auth/register/screens/register_mobile_number_screen.dart';
import 'package:pensol/app/modules/auth/register/screens/register_otp_screen.dart';
import 'package:pensol/app/modules/auth/register/screens/register_screen.dart';
import 'package:pensol/app/modules/menus/manualCouponEntry/screens/qr_screen.dart';
import 'package:pensol/app/modules/profile/profile_screen.dart';
import '../../app/modules/auth/login/screens/login_screen.dart';
import '../../app/modules/home/screens/home_screen.dart';
import '../../app/modules/menus/claimGift/screens/claim_gift_screen.dart';
import '../../app/modules/menus/couponHistory/screens/coupon_history_screen.dart';
import '../../app/modules/menus/giftCollection/screens/gift_collection_screen.dart';
import '../../app/modules/menus/giftStatus/screens/gift_status_screen.dart';
import '../../app/modules/menus/manualCouponEntry/screens/manual_coupon_code_screen.dart';
import '../../app/modules/menus/notification/screens/notification_screen.dart';
import '../../app/modules/menus/updatePin/screens/update_pin_screen.dart';
import '../../app/modules/onBoarding/on_boarding_page.dart';
import '../../app/modules/splash/splash_page.dart';
import '../../app/routes/error_route.dart';
import '../../app/routes/route_names.dart';
import '../../app/routes/route_transition.dart';
import '../modules/menus/notification/screens/notification_details.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.onBoarding:
        return buildRoute(const OnBoardingPage());
      case AppRoutes.splash:
        return buildRoute(const SplashPage());
      case AppRoutes.login:
        return buildRoute(const LoginScreen());
      case AppRoutes.registerMobileScreen:
        return buildRoute(const RegisterMobileNumberScreen());
      case AppRoutes.registerOTPScreen:
        return buildRoute(const RegisterOTPScreen());
      case AppRoutes.register:
        return buildRoute(const RegisterScreen());

      case AppRoutes.forgotPin:
        return buildRoute(const ForgotPasswordScreen());
      case AppRoutes.forgotPinOtp:
        return buildRoute(const ForgotPinOTPScreen());
      case AppRoutes.forgotPinNewPin:
        return buildRoute(const ForgotPinNewPinScreen());
      case AppRoutes.home:
        return buildRoute(const HomeScreen());
      case AppRoutes.profile:
        return buildRoute(const ProfileScreen());
      case AppRoutes.claimGift:
        return buildRoute(const ClaimGiftScreen());
      case AppRoutes.couponHistory:
        return buildRoute(const CouponHistoryScreen());
      case AppRoutes.giftCollection:
        return buildRoute(const GiftCollectionScreen());
      case AppRoutes.giftStatus:
        return buildRoute(const GiftStatusScreen());
      case AppRoutes.manualCouponEntry:
        return buildRoute(const ManualCouponCodeScreen());
      case AppRoutes.notification:
        return buildRoute(const NotificationScreen());
      case AppRoutes.updatePin:
        return buildRoute(const UpdatePinScreen());
      case AppRoutes.qrScan:
        return buildRoute(const QrScreen());
      default:
        return errorRoute();
    }
  }

  static buildRoute(Widget child) {
    return PageTransition(child);
  }
}
