import 'package:flutter/material.dart';
import 'package:qonstanta/helpers/F.dart';
import 'package:stacked/stacked.dart';

enum FontSize { Small, Medium, Big, Bigger }
List<int> fontSizeList = [14, 16, 18, 20];

class SettingViewModel extends FutureViewModel {
  String _title = 'Pengaturan';
  String get title => _title;

  // final _session = locator<SessionService>();

  FontSize fontSize = FontSize.Medium;
  bool autoNextQuestion = false;
  bool isDarkMode = false;

  @override
  Future futureToRun() async {
    debugPrint(_title);

    int _fontSize = await F.session.fontSize();
    switch (_fontSize) {
      case 14:
        fontSize = FontSize.Small;
        break;
      case 16:
        fontSize = FontSize.Medium;
        break;
      case 18:
        fontSize = FontSize.Big;
        break;
      case 20:
        fontSize = FontSize.Bigger;
        break;
    }
    // autoNextQuestion = await _session.isAutoNextQuestion();
    // isDarkMode = await _session.isDarkMode();

    notifyListeners();
  }

  Future fontSizeOnChanged(FontSize newValue) async {
    fontSize = newValue;
    // await _session.fontSize(value: fontSizeList[newValue.index]);

    notifyListeners();
  }

  Future autoNextQuestionChanged(bool newValue) async {
    // await _session.isAutoNextQuestion(value: autoNextQuestion = newValue);

    notifyListeners();
  }

  setFontSize() {}

  setDarkMode(BuildContext context, bool newValue) async {
    // getThemeManager(context).toggleDarkLightTheme();
    // getThemeManager(context).selectThemeAtIndex(newValue ? 1 : 0);
    // await _session.isDarkMode(value: isDarkMode = newValue);
    notifyListeners();
  }
}
