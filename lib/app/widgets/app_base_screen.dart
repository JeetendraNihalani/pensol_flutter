import 'package:flutter/material.dart';
import 'package:pensol/app/modules/home/providers/home_provider.dart';
import 'package:provider/provider.dart';
import '../../app.dart';
import '../../app/routes/route_names.dart';
import '../../app/constants/app_spacing.dart';
import '../../app/widgets/app_bar_widget.dart';
import '../../app/widgets/app_spacer.dart';
import '../../app/widgets/app_text_avatar.dart';
import '../../core/utils/extensions/screen_extension.dart';

class AppBaseScreen extends StatelessWidget {
  /// A const constructor.
  const AppBaseScreen({
    Key? key,
    this.title,
    this.child,
    this.onRefresh,
    this.showFab = false,
  }) : super(key: key);

  /// string app bar title
  final String? title;

  /// widget body child
  final Widget? child;

  /// A function that returns a Future of type void.
  final Future<void> Function()? onRefresh;

  /// A bool parameter that is passed to the widget to show fab.
  final bool showFab;

  /// A function that returns a widget.
  ///
  /// Args:
  ///   context (BuildContext): The current context of the widget.
  @override
  Widget build(BuildContext context) {
    /// Returning a widget.
    return Scaffold(
      /// A custom widget that I created.
      appBar: SimpleAppBar(
        title: title!,
        actions: [
          Consumer<HomeProvider>(
            builder: (context, user, child) {
              final firstName = user.userDetails.result?[0].vFirstName;
              final lastName = user.userDetails.result?[0].vFirstName;
              return Padding(
                padding: const EdgeInsets.all(AppSpacing.sm),
                child: TextAvatar(
                  text: '$firstName $lastName',
                  numberLetters: 2,
                ),
              );
            },
          ),
          AppSpacer.p8(),
        ],
      ),
      /// A widget that takes a specific size.
      body: SizedBox(
        height: context.height,
        width: context.width,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: RefreshIndicator(
            onRefresh: onRefresh ?? () async {},
            child: child ?? const SizedBox.shrink(),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      /// Creating a floating action button with a label.
      floatingActionButton: showFab
          ? FloatingActionButton.extended(
            backgroundColor: Theme.of(context).colorScheme.secondary,
              label: Row(
                children: [
                  const Icon(Icons.qr_code_2),
                  AppSpacer.p8(),
                  const Text('Scan Code'),
                ],
              ),
              onPressed: () {
                navigatorKey.currentState?.pushNamed(AppRoutes.qrScan);
              },
            )
          : null,
    );
  }
}
