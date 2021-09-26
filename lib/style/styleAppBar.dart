import 'package:flutter/material.dart';

class StyleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final Widget leading;
  final double? leadingWidth;
  final Widget title;
  final List<Widget> actions;
  final Color backgroundColor;
  final double? elevation;
  const StyleAppBar({
    Key? key,
    required this.height,
    required this.leading,
    this.leadingWidth,
    required this.title,
    required this.actions,
    required this.backgroundColor,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: elevation,
      toolbarHeight: height,
      title: title,
      actions: actions,
      leading: leading,
      leadingWidth: leadingWidth,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
