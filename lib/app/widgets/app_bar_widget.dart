import 'package:flutter/material.dart';

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SimpleAppBar({
    Key? key,
    required this.title,
    this.centerTitle = false,
    this.actions = const [],
  }) : super(key: key);

  /// string title
  final String title;

  /// bool center title
  final bool centerTitle;

  /// list of action widget
  final List<Widget> actions;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: centerTitle,
      actions: actions,
      
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
