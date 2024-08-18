import 'package:flutter/material.dart';
import 'package:qonstanta/ui/shared/ui_helper.dart';

class ListSwitch extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final bool? value;
  final Function(bool)? onChanged;

  const ListSwitch({
    Key? key,
    this.text,
    this.icon,
    this.value = false,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        padding: const EdgeInsets.fromLTRB(15, 10, 5, 10),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              child: Text(
                text!,
                style:
                    Theme.of(context).textTheme.button!.copyWith(fontSize: 14),
              ),
            ),
            Switch(value: value!, onChanged: onChanged)
          ],
        ),
      ),
    );
  }
}
