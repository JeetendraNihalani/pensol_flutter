// import 'package:flutter/material.dart';
// import 'package:pensolscanmaster/app/utils/app_spacer.dart';
// import 'package:pensolscanmaster/app/utils/images.dart';
// import 'package:pensolscanmaster/app/widgets/app_text.dart';
// import 'package:pensolscanmaster/core/services/internet_service.dart';
// import 'package:provider/provider.dart';
// import '../../../../../app/utils/colors.dart';
// import '../../core/extensions/screen_util_extension.dart';

// class AppBaseScreen extends StatefulWidget {
//   const AppBaseScreen({Key? key, this.child, this.appBar}) : super(key: key);

//   /// widget child
//   final Widget? child;

//   /// app bar widget
//   final PreferredSizeWidget? appBar;

//   @override
//   State<AppBaseScreen> createState() => _AppBaseScreenState();
// }

// class _AppBaseScreenState extends State<AppBaseScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final isOnline = Provider.of<ConnectivityProvider>(context).isOnline;
//     return Scaffold(
//       appBar: widget.appBar,
//       backgroundColor: AppColors.primaryColor,
//       body: SizedBox(
//           width: context.width,
//           height: context.height,
//           child: Stack(
//             children: [
//               Image.asset(AppImages.APP_BACKGROUND,
//                   fit: BoxFit.fill, height: context.height * 0.8),
//               if (isOnline) ...[
//                 widget.child ?? SizedBox.shrink(),
//               ] else ...[
//                 Align(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.wifi_off,
//                         color: AppColors.white,
//                         size: 32,
//                       ),
//                       AppSpacer.p16(),
//                       AppText(
//                         'No Internet Connection',
//                         fontSize: 20,
//                         textColor: AppColors.white,
//                       )
//                     ],
//                   ),
//                 )
//               ]
//             ],
//           )),
//     );
//   }
// }
