import 'package:flutter/material.dart';
import 'package:qonstanta/ui/shared/ui_helper.dart';

enum IconPosition { Left, Top, Right, Bottom }

/// A button that shows a busy indicator in place of title
class BusyButton extends StatelessWidget {
  final bool busy;
  final String title;
  final void Function() onPressed;
  final bool enabled;
  final Icon? icon;
  final IconPosition iconPosition;
  final Color? color;
  final double? width;
  final double? height;

  const BusyButton({
    Key? key,
    required this.title,
    this.busy = false,
    required this.onPressed,
    this.enabled = true,
    this.icon,
    this.color,
    this.iconPosition = IconPosition.Left,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color activeColor = color != null ? color! : primaryColor;
    return SizedBox(
      width: width ?? 150,
      height: height ?? 45,
      child: GestureDetector(
        onTap: busy ? null : onPressed,
        child: AnimatedContainer(
          height: busy ? 40 : 40,
          width: busy ? 40 : 40,
          duration: const Duration(milliseconds: 300),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
              horizontal: busy ? 10 : 15, vertical: busy ? 10 : 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: gradientColor),
            color: enabled ? activeColor : Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: !busy
              ? Text(
                  title,
                  style: bodyStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                )
              : SizedBox(
                  width: 25,
                  child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                ),
        ),
      ),
    );
  }
}
