import 'package:flutter/material.dart';

import './pill_gesture.dart';

BuildContext? _context;
double? _maxSize;

Future<T?> showBottomSlide<T>({
  required BuildContext context,
  required Widget child,
  String? title,
  Color? barrierColor,
  bool barrierDismissible = true,
  Duration transitionDuration = const Duration(milliseconds: 300),
  Color? pillColor,
  Color? backgroundColor,
  double maxSize = 1,
  bool movable = true,
}) {
  // assert(context != null);
  // assert(child != null);

  _context = context;
  _maxSize = maxSize;

  return showGeneralDialog(
    context: context,
    pageBuilder: (context, animation1, animation2) => Container(),
    barrierColor: barrierColor ?? Colors.black.withOpacity(0.7),
    barrierDismissible: barrierDismissible,
    barrierLabel: "Dismiss",
    transitionDuration: transitionDuration,
    transitionBuilder: (context, animation1, animation2, widget) {
      final curvedValue = Curves.easeInOut.transform(animation1.value) - 1.0;
      return Transform(
        transform: Matrix4.translationValues(0.0, curvedValue * -300, 0.0),
        child: Opacity(
          opacity: animation1.value,
          child: SlideDialog(
            child: child,
            pillColor: pillColor ?? Colors.blueGrey[200]!,
            backgroundColor: backgroundColor ?? Theme.of(context).canvasColor,
            maxSize: maxSize,
            title: title,
            movable: movable,
          ),
        ),
      );
    },
  );
}

class SlideDialog extends StatefulWidget {
  final Widget child;
  final Color? backgroundColor;
  final Color pillColor;
  final double maxSize;
  final String? title;
  final bool? movable;

  SlideDialog(
      {required this.child,
      required this.pillColor,
      this.backgroundColor,
      this.maxSize = 1,
      this.title,
      this.movable});

  @override
  _SlideDialogState createState() => _SlideDialogState();
}

class _SlideDialogState extends State<SlideDialog> {
  MediaQueryData _mediaQueryData = MediaQuery.of(_context!);
  double deviceWidth = MediaQuery.of(_context!).size.width;
  double deviceHeight = MediaQuery.of(_context!).size.height;
  double paddingTop = MediaQuery.of(_context!).padding.top;
  double _currentPosition =
      MediaQuery.of(_context!).size.height * (1 - _maxSize!);

  @override
  Widget build(BuildContext context) {
    _currentPosition = _currentPosition < 1 ? paddingTop : _currentPosition;

    BorderRadius _borderRadius = BorderRadius.only(
      topLeft: Radius.circular(20.0),
      topRight: Radius.circular(20.0),
    );

    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets +
          EdgeInsets.only(top: _currentPosition),
      duration: Duration(milliseconds: 100),
      curve: Curves.decelerate,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: Container(
            width: deviceWidth,
            height: deviceHeight - paddingTop,
            child: Material(
              color: widget.backgroundColor ??
                  Theme.of(context).dialogBackgroundColor,
              elevation: 24.0,
              type: MaterialType.card,
              shape: RoundedRectangleBorder(
                borderRadius: _borderRadius,
              ),
              child: Column(
                children: <Widget>[
                  Material(
                    shape: RoundedRectangleBorder(
                      borderRadius: _borderRadius,
                    ),
                    elevation: 5.0,
                    child: Column(
                      children: [
                        widget.movable!
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: PillGesture(
                                  title: widget.title == null
                                      ? Container()
                                      : Text(
                                          widget.title!,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                  pillColor: widget.pillColor,
                                  onVerticalDragStart: _onVerticalDragStart,
                                  onVerticalDragEnd: _onVerticalDragEnd,
                                  onVerticalDragUpdate: _onVerticalDragUpdate,
                                ),
                              )
                            : Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: widget.title == null
                                              ? Container()
                                              : Text(
                                                  widget.title!,
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.close),
                                        onPressed: () => Navigator.pop(context),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                  Expanded(child: SingleChildScrollView(child: widget.child)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onVerticalDragStart(DragStartDetails drag) {
    setState(() {
      // _initialPosition = drag.globalPosition.dy;
    });
  }

  void _onVerticalDragUpdate(DragUpdateDetails drag) {
    setState(() {
      final temp = _currentPosition;
      _currentPosition = drag.globalPosition.dy;
      // print(drag.globalPosition.dy);
      if (_currentPosition < 0) {
        _currentPosition = temp;
      }
    });
  }

  void _onVerticalDragEnd(DragEndDetails drag) {
    double _offset75 = deviceHeight * (1 - 0.75);
    double _offset50 = deviceHeight * (1 - 0.5);
    double _offset35 = deviceHeight * (1 - 0.35);

    if (_currentPosition > _offset35) {
      Navigator.pop(context);
      return;
    }
    setState(() {
      if (_currentPosition < _offset75)
        _currentPosition = _mediaQueryData.padding.top;
      else if (_currentPosition < _offset50)
        _currentPosition = _offset75;
      else if (_currentPosition < _offset35) _currentPosition = _offset50;
    });
  }
}
