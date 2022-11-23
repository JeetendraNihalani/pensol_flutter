import 'dart:async';
import 'package:flutter/material.dart';
import '../../../app/modules/home/screens/home_screen.dart';
import '../../../core/services/auth_service.dart';
import '../../../app/constants/app_string.dart';
import '../../../app/modules/auth/login/screens/login_screen.dart';
import '../../../core/utils/extensions/screen_extension.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _a = false;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 700), () {
      setState(() {
        _a = !_a;
      });
    });
    Timer(const Duration(milliseconds: 2000), () async {
      
      final _userDetails = await AuthService().userDetails();

      if (_userDetails == null || _userDetails == '') {
        Navigator.of(context)
            .pushReplacement(SlideTransitionAnimation(const LoginScreen()));
      } else {
        Navigator.of(context)
            .pushReplacement(SlideTransitionAnimation(const HomeScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 2000),
            curve: Curves.fastLinearToSlowEaseIn,
            width: _a ? context.width : 0,
            height: context.height,
            color: Theme.of(context).colorScheme.secondary,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png'),
                Text(
                  AppString.appName,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SlideTransitionAnimation extends PageRouteBuilder {
  final Widget page;

  SlideTransitionAnimation(this.page)
      : super(
            pageBuilder: (context, animation, anotherAnimation) => page,
            transitionDuration: const Duration(milliseconds: 2000),
            transitionsBuilder: (context, animation, anotherAnimation, child) {
              animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
              );
              return SlideTransition(
                position: Tween(
                  begin: const Offset(1.0, 0.0),
                  end: const Offset(0.0, 0.0),
                ).animate(animation),
                textDirection: TextDirection.rtl,
                child: page,
              );
            });
}
