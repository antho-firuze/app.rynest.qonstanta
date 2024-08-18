import 'package:flutter/material.dart';
import 'package:qonstanta/ui/shared/ui_helper.dart';

class TextLink extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  const TextLink(this.text, {this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16,
          color: primaryColor,
          fontFamily: 'Roboto',
        ),
      ),
    );
  }
}
