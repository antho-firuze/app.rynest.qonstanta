import 'package:flutter/material.dart';
import 'package:qonstanta/ui/shared/app_bar.dart';
import 'package:qonstanta/ui/views/widgets/list_switch.dart';
import 'package:stacked/stacked.dart';

import 'setting_viewmodel.dart';

BuildContext? _context;
SettingViewModel? _model;

class SettingView extends StatelessWidget {
  final bool showBack;
  const SettingView({Key? key, this.showBack = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingViewModel>.reactive(
        onModelReady: (model) async {
          _context = context;
          _model = model;
        },
        builder: (context, model, child) => Scaffold(
            appBar: appBar(context, _model!.title, showBack: showBack),
            resizeToAvoidBottomInset: false,
            backgroundColor: Theme.of(context).backgroundColor,
            body: Stack(children: [content])),
        viewModelBuilder: () => SettingViewModel());
  }

  get bg => Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background_b.png'),
                fit: BoxFit.cover)),
      );

  get content => SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ListMenu(
                //   text: 'Ukuran Huruf',
                //   icon: Icons.font_download,
                //   onPressed: () => showBottomSlide(
                //     context: _context,
                //     title: 'Ukuran Huruf',
                //     maxSize: 0.35,
                //     child: fontSizeSetting,
                //   ),
                // ),
                // ListSwitch(
                //   text: 'Otomatis pindah pertanyaan',
                //   icon: Icons.question_answer,
                //   value: _model.autoNextQuestion,
                //   onChanged: (val) async =>
                //       await _model.autoNextQuestionChanged(val),
                // ),
                // SwitchListTile(value: value, onChanged: onChanged),
                ListSwitch(
                  text: 'Dark Mode',
                  icon: Icons.question_answer,
                  value: _model!.isDarkMode,
                  onChanged: (val) async =>
                      await _model!.setDarkMode(_context!, val),
                  // onChanged: (val) {
                  //   getThemeManager(_context).selectThemeAtIndex(val ? 1 : 0);
                  //   _model.isDarkMode = val;
                  //   _model.notifyListeners();
                  // },
                ),
              ],
            ),
          ),
        ),
      );

  get fontSizeSetting => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RadioListTile<FontSize>(
            dense: true,
            title: const Text('Kecil', style: TextStyle(fontSize: 14)),
            value: FontSize.Small,
            groupValue: _model!.fontSize,
            onChanged: (FontSize? value) {
              _model!.fontSizeOnChanged(value!);
              Navigator.pop(_context!);
            },
          ),
          RadioListTile<FontSize>(
            dense: true,
            title: const Text('Sedang', style: TextStyle(fontSize: 16)),
            value: FontSize.Medium,
            groupValue: _model!.fontSize,
            onChanged: (FontSize? value) {
              _model!.fontSizeOnChanged(value!);
              Navigator.pop(_context!);
            },
          ),
          RadioListTile<FontSize>(
            dense: true,
            title: const Text('Besar', style: TextStyle(fontSize: 18)),
            value: FontSize.Big,
            groupValue: _model!.fontSize,
            onChanged: (FontSize? value) {
              _model!.fontSizeOnChanged(value!);
              Navigator.pop(_context!);
            },
          ),
          RadioListTile<FontSize>(
            dense: true,
            title: const Text('Super Besar', style: TextStyle(fontSize: 20)),
            value: FontSize.Bigger,
            groupValue: _model!.fontSize,
            onChanged: (FontSize? value) {
              _model!.fontSizeOnChanged(value!);
              Navigator.pop(_context!);
            },
          ),
        ],
      );
}
