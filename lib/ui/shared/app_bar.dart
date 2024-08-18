import 'package:flutter/material.dart';
import 'package:qonstanta/ui/shared/ui_helper.dart';

AppBar appBar(
  final BuildContext context,
  final String title, {
  final String? titleColor,
  final Color? backgroundColor,
  final bool centerTitle = false,
  final bool showBack = true,
  final Function? onBackPressed,
  final List<Widget>? actions,
}) =>
    AppBar(
      title: Text(
        title,
        style: heading3Style,
      ),
      backgroundColor: backgroundColor ?? primaryColor,
      // backgroundColor: primaryColor,
      elevation: 0.0,
      centerTitle: centerTitle,
      automaticallyImplyLeading: false,
      leading: showBack
          ? IconButton(
              icon: Icon(Icons.arrow_back),
              color: titleColor == null ? Colors.white : Colors.black54,
              onPressed: () => Navigator.of(context).pop(false),
            )
          : null,
      actions: actions,
    );
