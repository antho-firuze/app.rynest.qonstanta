import 'package:flutter/material.dart';
import 'package:qonstanta/ui/shared/ui_helper.dart';

class MenuCard extends StatelessWidget {
  final String title;
  final String? imageSrc;
  final Function()? onTap;
  final Color color;
  const MenuCard({
    Key? key,
    required this.title,
    this.imageSrc,
    this.onTap,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            offset: Offset(2, 3),
            blurRadius: 10.0,
            spreadRadius: -3,
            color: shadowColor,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              child: Column(
                children: [
                  // SizedBox(height: 15,),
                  Spacer(),
                  Image.asset(
                    imageSrc ?? 'assets/icons/icon_menu_default.png',
                    height: 60.0,
                    color: ThemeData().textTheme.bodyText1!.color,
                  ),
                  Spacer(),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .button!
                        .copyWith(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
