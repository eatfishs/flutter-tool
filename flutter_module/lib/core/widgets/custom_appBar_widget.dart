import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  final VoidCallback? onBackPressed;

  CustomAppBar({
    required this.title,
    this.actions = const [],
    this.onBackPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: onBackPressed != null
          ? IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: onBackPressed,
        tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      )
          : null,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}