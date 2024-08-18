import 'package:qonstanta/helpers/progress_dialog_helper.dart';
import 'package:stacked/stacked.dart';

class MyBaseViewModel extends BaseViewModel {
  void setBuzy(bool value) async {
    setBusy(value);
    if (value) {
      await Future.delayed(const Duration(microseconds: 500));
      progressDialog.show();
    } else {
      await Future.delayed(const Duration(microseconds: 500));
      if (!await progressDialog.hide()) await progressDialog.hide();
      await Future.delayed(const Duration(microseconds: 1500));
      if (!await progressDialog.hide()) await progressDialog.hide();
      if (progressDialog.isShowing()) await progressDialog.hide();
    }
  }
}
