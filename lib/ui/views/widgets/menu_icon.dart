import 'package:flutter/material.dart';
import 'package:qonstanta/ui/shared/ui_helper.dart';

class MenuIcon extends StatelessWidget {
  final String? title;
  final String? image;
  final Icon? icon;
  final Function()? onTap;
  final Color color;
  const MenuIcon({
    Key? key,
    this.title,
    this.image,
    this.onTap,
    this.color = Colors.white,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: gradientColor),
              borderRadius: BorderRadius.circular(20),
            ),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: icon ?? Icon(Icons.menu_book),
              // child: Image.asset(
              //   image ?? 'assets/icons/icon_menu_default.png',
              //   height: 20.0,
              //   color: oWhite,
              // ),
            ),
          ),
          if (title != null) ...[
            vSpaceXSmall,
            Text(
              title!,
              textAlign: TextAlign.center,
              style: captionStyle.copyWith(fontSize: 10, color: shadowColor),
            ),
          ]
        ],
      ),
    );
  }
}
