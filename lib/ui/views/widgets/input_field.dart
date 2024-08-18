import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qonstanta/ui/shared/ui_helper.dart';
import 'package:qonstanta/ui/views/widgets/gradient_mask.dart';

enum InputStyle { style1, style2 }

class InputField extends StatefulWidget {
  final String? label;
  final String? placeholder;
  final TextEditingController controller;
  final bool password;
  final bool isReadOnly;
  final bool smallVersion;
  final int maxLines;
  final FocusNode? fieldFocusNode;
  final FocusNode? nextFocusNode;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final String? additionalNote;
  final Function? enterPressed;
  final Function(String)? onChanged;
  final TextInputFormatter? formatter;
  final String? Function(String?)? validator;
  final Widget? icon;
  final Widget? action;
  final InputStyle inputStyle;

  InputField(
      {required this.controller,
      this.placeholder,
      this.label,
      this.enterPressed,
      this.fieldFocusNode,
      this.nextFocusNode,
      this.additionalNote,
      this.onChanged,
      this.formatter,
      this.textInputAction = TextInputAction.next,
      this.textInputType = TextInputType.text,
      this.password = false,
      this.isReadOnly = false,
      this.smallVersion = false,
      this.maxLines = 1,
      this.icon,
      this.validator,
      this.action, this.inputStyle = InputStyle.style1});

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool? isPassword;

  @override
  void initState() {
    super.initState();
    isPassword = widget.password;
  }

  @override
  Widget build(BuildContext context) {
    // double fieldHeight = widget.label != null ? 75 : 55;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Text(
            widget.label!,
            style: captionStyle.clr(fontColor),
          ),
        vSpace(5.0),
        Container(
          // height: widget.smallVersion ? 55 : fieldHeight,
          alignment: Alignment.centerLeft,
          padding: fieldPadding,
          decoration: widget.inputStyle == InputStyle.style1
              ? field1Decoration
              : field2Decoration,
          // decoration: widget.isReadOnly ? disabledFieldDecortaion : fieldDecortaion,
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: widget.controller,
                  keyboardType: widget.textInputType,
                  focusNode: widget.fieldFocusNode,
                  textInputAction: widget.textInputAction,
                  onChanged: widget.onChanged,
                  maxLines: widget.maxLines,
                  inputFormatters:
                      widget.formatter != null ? [widget.formatter!] : null,
                  onEditingComplete: () {
                    if (widget.enterPressed != null) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      widget.enterPressed!();
                    }
                  },
                  onFieldSubmitted: (value) {
                    if (widget.nextFocusNode != null) {
                      widget.nextFocusNode?.requestFocus();
                    }
                  },
                  autovalidateMode: AutovalidateMode.always,
                  validator: widget.validator,
                  obscureText: isPassword!,
                  enabled: !widget.isReadOnly,
                  readOnly: widget.isReadOnly,
                  decoration: widget.inputStyle == InputStyle.style1
                      ? style1()
                      : style2(),
                  // decoration: widget.label != null ? withLabel() : withoutLabel(),
                  style: oStyle.clr(oWhite),
                ),
              ),
              widget.password
                  ? GestureDetector(
                      onTap: () => setState(() {
                        isPassword = !isPassword!;
                      }),
                      child: widget.password
                          ? Container(
                              width: fieldHeight,
                              height: fieldHeight,
                              alignment: Alignment.center,
                              child: LinearGradientMask(
                                child: Icon(
                                  isPassword!
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey[200],
                                ),
                              ))
                          : Container(),
                    )
                  : widget.action == null
                      ? Container()
                      : widget.action!,
            ],
          ),
        ),
      ],
    );
  }

  InputDecoration style1() => InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        icon: widget.icon == null ? Icon(Icons.edit) : widget.icon,
        hintText: widget.placeholder,
        hintStyle: captionStyle.clr(hintColor),
        counterText: '',
      );

  InputDecoration style2() => InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        icon: widget.icon == null ? Icon(Icons.edit) : widget.icon,
        hintText: widget.placeholder,
        hintStyle: captionStyle.clr(hintColor),
        counterText: '',
      );

  InputDecoration withLabel() => InputDecoration(
        labelText: widget.label,
        labelStyle:
            TextStyle(fontSize: widget.smallVersion ? 15 : 16, height: 0),
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
        // border: InputBorder.none,
        // focusedBorder: InputBorder.none,
        // enabledBorder: InputBorder.none,
        // errorBorder: InputBorder.none,
        // disabledBorder: InputBorder.none,
        icon: widget.icon == null ? Icon(Icons.edit) : widget.icon,
        hintText: widget.placeholder,
        hintStyle: oStyle.size(widget.smallVersion ? 12 : 15).clr(Colors.grey),
      );

  InputDecoration withoutLabel() => InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        icon: widget.icon == null ? Icon(Icons.edit) : widget.icon,
        hintText: widget.placeholder,
        hintStyle: oStyle.size(widget.smallVersion ? 12 : 15).clr(Colors.grey),
      );
}
