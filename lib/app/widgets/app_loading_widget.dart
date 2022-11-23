import 'package:flutter/material.dart';

/// `AppLoadingWidget` is a `StatelessWidget` that displays a loading indicator
class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
