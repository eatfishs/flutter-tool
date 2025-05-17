import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  final VoidCallback? onBackPressed;

  const CustomAppBar({
    required this.title,
    this.actions = const [],
    this.onBackPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(title),
        leading: onBackPressed != null
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: onBackPressed,
                tooltip: MaterialLocalizations.of(context).backButtonTooltip,
              )
            : null,
        actions: actions,
        backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
