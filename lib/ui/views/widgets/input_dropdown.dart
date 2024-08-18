import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:qonstanta/ui/shared/ui_helper.dart';

class InputDropdown<T> extends StatelessWidget {
  final String label;
  final String? placeholder;
  final bool enabled;
  final bool smallVersion;
  final T? selectedItem;
  final String Function(T value)? itemAsString;
  final Future<List<T>> Function(String filter)? onFind;
  final void Function(T? value)? onChanged;
  final bool allowNewEntry;
  final bool showClearButton;
  final VoidCallback? onAddNewEntry;
  final Widget? icon;
  final String? validationMessage;
  final List<T>? items;
  final bool showSearchBox;
  final bool showSelectedItem;
  final bool Function(T i, T? s)? compareFn;
  final Widget Function(BuildContext, T?, String)? dropdownBuilder;
  final Widget Function(BuildContext, T, bool)? popupItemBuilder;
  final String Function(T?)? validator;
  final AutovalidateMode autoValidateMode;

  const InputDropdown(this.label,
      {Key? key,
      this.placeholder,
      this.selectedItem,
      this.itemAsString,
      this.onFind,
      this.onChanged,
      this.enabled = true,
      this.smallVersion = false,
      this.allowNewEntry = false,
      this.showClearButton = false,
      this.onAddNewEntry,
      this.validationMessage,
      this.items,
      this.showSearchBox = false,
      this.showSelectedItem = false,
      this.compareFn,
      this.dropdownBuilder,
      this.popupItemBuilder,
      this.autoValidateMode = AutovalidateMode.disabled,
      this.validator,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _defaultPopupItemBuilder(
        BuildContext context, T item, bool isSelected) {
      return ListTile(
        dense: false,
        title: Text(
          item is String ? item : itemAsString!(item),
          style: TextStyle(fontSize: 14),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(hintText, style: TextStyle(color: Colors.black54)),
        // SizedBox(height: 4),
        Container(
          // height: smallVersion ? 40 : fieldHeight,
          alignment: Alignment.centerLeft,
          padding: fieldPadding,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: icon == null ? Icon(Icons.edit) : icon,
              ),
              Expanded(
                child: DropdownSearch<T>(
                  enabled: enabled,
                  mode: Mode.BOTTOM_SHEET,
                  items: items,
                  label: label,
                  isFilteredOnline: true,
                  autoFocusSearchBox: true,
                  showClearButton: showClearButton,
                  showSearchBox: showSearchBox,
                  selectedItem: selectedItem,
                  itemAsString: itemAsString,
                  showSelectedItem: showSelectedItem,
                  compareFn: compareFn,
                  loadingBuilder: (context, val) =>
                      Center(child: CircularProgressIndicator()),
                  popupShape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(14))),
                  popupTitle: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Text(
                      'Pilih $label',
                      style: oStyle.size(16).bold,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  popupItemBuilder: popupItemBuilder != null
                      ? popupItemBuilder
                      : _defaultPopupItemBuilder,
                  emptyBuilder: (context, val) {
                    var style = oStyle.size(14);
                    if (allowNewEntry)
                      return ListTile(
                        leading: Icon(Icons.add_circle, color: primaryColor),
                        dense: true,
                        title: Text(
                          'Tambah entri baru...',
                          style: style.clr(primaryColor),
                        ),
                        onTap: onAddNewEntry,
                      );
                    else
                      return showSearchBox
                          ? val!.length < 3
                              ? ListTile(
                                  title: Text(
                                  'Input min. 3 character',
                                  style: style,
                                ))
                              : ListTile(
                                  title: Text(
                                  'Data tidak ditemukan',
                                  style: style,
                                ))
                          : SizedBox();
                  },
                  dropdownSearchDecoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(right: 0),
                  ),
                  dropDownButton: Icon(
                    Icons.arrow_drop_down,
                    color: enabled ? Colors.black54 : Colors.black12,
                    size: 35,
                  ),
                  dropdownBuilder: dropdownBuilder,
                  maxHeight: safeBlockVertical * 50,
                  onFind: onFind,
                  onChanged: onChanged,
                  autoValidateMode: autoValidateMode,
                  validator: validator,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
