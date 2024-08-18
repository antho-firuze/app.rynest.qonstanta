import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    this.leading,
    this.title,
    this.subTitle,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.backgroundColor,
    this.tailColor,
    this.actions,
  }) : super(key: key);

  final Widget? leading;
  final Widget? title;
  final Widget? subTitle;
  final Widget? trailing;
  final Function()? onTap;
  final Function()? onLongPress;
  final Color? backgroundColor;
  final Color? tailColor;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Card(
        color: backgroundColor,
        elevation: 2,
        margin: const EdgeInsets.all(2.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: ClipPath(
          child: Container(
            decoration: BoxDecoration(
              border: Border(right: BorderSide(color: tailColor ?? Colors.green, width: 16)),
            ),
            child: Row(
              children: [
                Flexible(
                  child: ListTile(
                    leading: leading,
                    title: title,
                    subtitle: subTitle,
                  ),
                ),
                Row(
                  children: actions ?? [],
                ),
              ],
            ),
          ),
          clipper: ShapeBorderClipper(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
    );
  }
}
