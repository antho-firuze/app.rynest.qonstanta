import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:qonstanta/ui/views/widgets/gradient_mask.dart';

BuildContext? ctx = Get.key.currentContext;

const Color primaryColor = Color.fromARGB(255, 13, 13, 40);
const Color secondaryColor = Color.fromARGB(255, 78, 88, 245);
const Color tertiaryColor = Color.fromARGB(255, 133, 64, 237);
const Color quaternaryColor = Color.fromARGB(255, 247, 0, 111);

List<Color> gradientColor = [secondaryColor, tertiaryColor, quaternaryColor];

const Color backgroundColor = Color.fromARGB(255, 26, 27, 30);
const Color shadowColor = Colors.grey;
const Color linkColor = tertiaryColor;
const Color fontColor = shadowColor;
const Color hintColor = Colors.grey;

const Color lightGrey = Color.fromARGB(255, 61, 63, 69);
const Color darkGrey = Color.fromARGB(255, 18, 18, 19);
const Color oWhite = Colors.white;
const Color oBlack = Colors.black;

const double spaceXS = 10.0;
const double spaceS = 20.0;
const double spaceM = 40.0;
const double spaceL = 80.0;
const double spaceXL = 120.0;

Widget hSpace(double val) => SizedBox(width: val);
const Widget hSpaceXSmall = SizedBox(width: spaceXS);
const Widget hSpaceSmall = SizedBox(width: spaceS);
const Widget hSpaceMedium = SizedBox(width: spaceM);
const Widget hSpaceLarge = SizedBox(width: spaceL);
const Widget hSpaceXLarge = SizedBox(width: spaceXL);

Widget vSpace(double val) => SizedBox(height: val);
const Widget vSpaceXSmall = SizedBox(height: spaceXS);
const Widget vSpaceSmall = SizedBox(height: spaceS);
const Widget vSpaceMedium = SizedBox(height: spaceM);
const Widget vSpaceLarge = SizedBox(height: spaceL);
const Widget vSpaceXLarge = SizedBox(height: spaceXL);

const TextStyle oStyle = TextStyle();
final Image oImagePlaceholder = Image.asset(
  'assets/images/im_photo_placeholder.gif',
  fit: BoxFit.cover,
);

MediaQueryData _mq = MediaQuery.of(ctx!);
double _safeAreaH = _mq.padding.left + _mq.padding.right;
double _safeAreaV = _mq.padding.top + _mq.padding.bottom;
double screenWidth = _mq.size.width;
double screenHeight = _mq.size.height;
double screenWidthPercentage({double percentage = 1}) =>
    screenWidth * percentage;
double screenHeightPercentage({double percentage = 1}) =>
    screenHeight * percentage;
double safeScreenWidth = screenWidth - _safeAreaH;
double saveScreenHeight = screenHeight - _safeAreaV;
double blockHorizontal = screenWidth / 100;
double blockVertical = screenHeight / 100;
double safeBlockHorizontal = safeScreenWidth / 100;
double safeBlockVertical = saveScreenHeight / 100;

// S => 6-7" => W x H (360/500 x 640/1000)
// M => 10" => W x H (800 x 1232)
// L => 12" => W x H (1024 x 1366)
double screenWidthProp(
        {required double s, required double m, required double l}) =>
    screenWidth < 500
        ? s
        : screenWidth < 1024
            ? m
            : l;
double screenHeightProp(
        {required double s, required double m, required double l}) =>
    screenHeight < 1000
        ? s
        : screenHeight < 1350
            ? m
            : l;

Widget divider({
  Color? color,
  EdgeInsets padding = EdgeInsets.zero,
  isHorizontal = true,
}) =>
    Padding(
      padding: padding,
      child: Container(
        width: isHorizontal ? null : 2,
        height: isHorizontal ? 2 : null,
        color: color != null ? color : Colors.grey[300],
      ),
    );

// Box Decorations
BoxDecoration field1Decoration = BoxDecoration(
  borderRadius: BorderRadius.circular(25),
  color: Colors.transparent,
  border: Border.all(color: Colors.grey, width: 1.0),
);

BoxDecoration field2Decoration = BoxDecoration(
  borderRadius: BorderRadius.circular(10),
  color: Colors.grey[100],
  // border: Border.all(color: Colors.grey, width: 1.0),
);

// BoxDecoration disabledFieldDecortaion = BoxDecoration(
//   borderRadius: BorderRadius.circular(20),
//   color: Colors.grey[100],
//   // border: Border.all(color: Colors.grey, width: 2.0),
// );

// Font Size
const double fontXS = 12;
const double fontS = 14;
const double fontM = 16;
const double fontL = 18;
const double fontXL = 20;
const double fontXXL = 22;
const double fontXXXL = 24;

// Font Family
const String fontRoboto = 'Roboto';
const String fontPoppins = 'Poppins';

// Field Variables
const double fieldHeight = 55;
const double smallFieldHeight = 40;
const double inputFieldBottomMargin = 30;
const double inputFieldSmallBottomMargin = 0;
const EdgeInsets fieldPadding = const EdgeInsets.symmetric(horizontal: 15);
const EdgeInsets largeFieldPadding =
    const EdgeInsets.symmetric(horizontal: 15, vertical: 15);

// Text Style Variables
const TextStyle heading1Style = TextStyle(
  fontSize: 34,
  fontWeight: FontWeight.w400,
  fontFamily: "Cinzel",
  color: oWhite,
);

const TextStyle heading2Style = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.w600,
  fontFamily: "Cinzel",
  color: oWhite,
);

const TextStyle heading3Style = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w600,
  fontFamily: "Cinzel",
  color: oWhite,
);

const TextStyle headlineStyle = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.w700,
  fontFamily: "Cinzel",
  color: oWhite,
);

const TextStyle bodyStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  color: oWhite,
);

const TextStyle subheadingStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w400,
  color: oWhite,
);

const TextStyle captionStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w400,
  color: oWhite,
);

extension TextStyleHelpers on TextStyle {
  TextStyle family(String family) => copyWith(fontFamily: family);
  TextStyle clr(Color color) => copyWith(color: color);
  TextStyle size(double size) => copyWith(fontSize: size);
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);
  TextStyle letterSpace(double value) => copyWith(letterSpacing: value);
}

Widget iconMask(IconData icon, {double? size, Color? color}) =>
    LinearGradientMask(
        child: Icon(
      icon,
      color: color ?? oWhite,
      size: size,
    ));

Widget iconFaMask(IconData icon, {double? size, Color? color}) =>
    LinearGradientMask(
        child: FaIcon(
      icon,
      color: color ?? oWhite,
      size: size ?? 20.0,
    ));

Widget iconFa(IconData icon, {double? size, Color? color}) => FaIcon(
      icon,
      color: color ?? oWhite,
      size: size ?? 20.0,
    );

Widget gradientMask({required Widget child}) => LinearGradientMask(
      child: child,
    );
