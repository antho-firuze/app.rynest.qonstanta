import 'package:flutter/material.dart';
import 'package:qonstanta/ui/shared/ui_helper.dart';

class ListMenu extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final Function()? onPressed;

  const ListMenu({
    Key? key,
    this.text,
    this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        onPressed: onPressed,
        // padding: const EdgeInsets.all(15),
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        // color: Theme.of(context).cardColor,
        child: Row(
          children: [
            icon == null
                ? SizedBox(height: 33)
                : Icon(
                    icon,
                    size: 33,
                    color: Theme.of(context).accentColor,
                  ),
            hSpaceXSmall,
            Expanded(
                child: Text(text!, style: Theme.of(context).textTheme.button)),
            Icon(Icons.arrow_forward_ios, color: Theme.of(context).accentColor),
          ],
        ),
      ),
    );
  }
}
