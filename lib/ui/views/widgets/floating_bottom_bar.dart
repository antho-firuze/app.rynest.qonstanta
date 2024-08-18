import 'package:flutter/material.dart';
import 'package:qonstanta/ui/shared/ui_helper.dart';

class FloatingBottomBar extends StatefulWidget {
  final PageController controller;
  final List<FloatingBottomBarItem> items;
  final Color? activeColor;
  final Color? color;
  final Function(int index)? onTap;

  const FloatingBottomBar(
      {required this.controller,
      required this.items,
      this.activeColor,
      this.color,
      Key? key,
      this.onTap})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _FloatingBottomBarState();
}

class _FloatingBottomBarState extends State<FloatingBottomBar> {
  GlobalKey _keyBottomBar = GlobalKey();
  // double? _numPositionBase, _numDifferenceBase, _positionLeftIndicatorDot;
  int _indexPageSelected = 0;
  Color? _color, _activeColor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _color = widget.color ?? Colors.black45;
    _activeColor = widget.activeColor ?? Theme.of(context).primaryColor;
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback(_afterLayout);
    super.initState();
  }

  _afterLayout(_) {
    // final sizeBottomBar =
    //     (_keyBottomBar.currentContext!.findRenderObject() as RenderBox).size;
    // _numPositionBase = ((sizeBottomBar.width / widget.items.length));
    // _numDifferenceBase = (_numPositionBase! - (_numPositionBase! / 2) + 2);
    setState(() {
      // _positionLeftIndicatorDot = _numPositionBase! - _numDifferenceBase!;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Page => ${widget.controller.page}');
    return Container(
      padding: EdgeInsets.only(
        left: screenWidth < 1000 ? 20.0 : 300.0,
        right: screenWidth < 1000 ? 20.0 : 300.0,
        bottom: 20,
      ),
      child: Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Stack(
              key: _keyBottomBar,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: _createButtonList(widget.items.asMap()),
                ),
              ],
            ),
          )),
    );
  }

  List<_Item> _createButtonList(Map<int, FloatingBottomBarItem> mapItem) {
    List<_Item> children = [];
    mapItem.forEach(
      (index, item) => children.add(
        _Item(
          index,
          icon: item.icon,
          label: item.label,
          color: (index == _indexPageSelected) ? _activeColor! : _color!,
          onTap: (index) {
            _changeOptionBottomBar(index);
            return widget.onTap!(index);
          },
        ),
      ),
    );
    return children;
  }

  void _changeOptionBottomBar(int indexPageSelected) {
    if (indexPageSelected != _indexPageSelected) {
      setState(() {
        // _positionLeftIndicatorDot =
        //     (_numPositionBase! * (indexPageSelected + 1)) - _numDifferenceBase!;
      });
      _indexPageSelected = indexPageSelected;
    }
  }
}

class FloatingBottomBarItem {
  final IconData icon;
  final String? label;
  const FloatingBottomBarItem(this.icon, {this.label});
}

class _Item extends StatelessWidget {
  final int index;
  final IconData? icon;
  final String? label;
  final Color? color;
  final Function(int index)? onTap;

  const _Item(this.index,
      {this.icon, this.label, this.color, this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: SizedBox.fromSize(
        size: const Size(40, 40),
        child: RawMaterialButton(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(0.0),
          onPressed: () => onTap!(index),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color),
              if (label != null) ...[
                const SizedBox(
                  height: 3.0,
                ),
                Text(label!),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
