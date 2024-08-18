import 'package:flutter/material.dart';
import 'package:qonstanta/api/api_service.dart';
import 'package:qonstanta/app/app.locator.dart';
import 'package:qonstanta/helpers/F.dart';
import 'package:qonstanta/helpers/result.dart';
import 'package:stacked/stacked.dart';

import 'otp_view.dart';
import 'reset_pwd_view.dart';

class ForgotPwdViewModel extends FutureViewModel {
  String _title = 'Lupa Password';
  String get title => _title;

  final _api = locator<ApiService>();

  final emailCtrl = TextEditingController();
  final passwordNewCtrl = TextEditingController();
  final passwordNewConfirmCtrl = TextEditingController();
  final emailFocus = FocusNode();
  final passwordNewFocus = FocusNode();
  final passwordNewConfirmFocus = FocusNode();

  @override
  Future futureToRun() async {
    debugPrint(_title);

    notifyListeners();
  }

  Future sendOTP() async {
    if (isBusy) return;

    int err = 0;
    if (emailCtrl.text.isEmpty) err++;
    if (err > 0) return await F.showInfoDialog('Harap kolom email di isi !');

    await forgotPassword();
  }

  Future forgotPassword() async {
    setBusy(true);
    Result _result = await _api.forgotPassword(email: emailCtrl.text.trim());
    setBusy(false);

    if (!_result.status) return await F.showErrorDialog(_result.message!);

    bool resultOTP = await F.navigateWithTransition(OtpView());

    if (resultOTP) {
      F.back();
      await F.navigateWithTransition(ResetPwdView());
    }
  }
}
