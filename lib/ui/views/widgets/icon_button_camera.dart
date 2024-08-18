import 'package:flutter/material.dart';

class IconButtonCamera extends StatelessWidget {
  final Function()? onPressed;

  const IconButtonCamera({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      child: TextButton(
        onPressed: onPressed,
        // padding: EdgeInsets.zero,
        // color: primaryColor,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(50),
        //   side: BorderSide(color: Colors.white),
        // ),
        child: Icon(
          Icons.camera_alt_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
