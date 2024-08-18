import 'package:flutter/material.dart';
import 'package:qonstanta/api/api_service.dart';
import 'package:qonstanta/app/app.locator.dart';
import 'package:qonstanta/helpers/F.dart';
import 'package:qonstanta/helpers/result.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ResetPwdViewModel extends FutureViewModel {
  String _title = 'Reset Password';
  String get title => _title;

  final _api = locator<ApiService>();

  final passwordCtrl = TextEditingController();
  final passwordConfirmCtrl = TextEditingController();
  final passwordFocus = FocusNode();
  final passwordConfirmFocus = FocusNode();

  int? otp;

  @override
  Future futureToRun() async {
    debugPrint(_title);

    otp = _api.otp;

    notifyListeners();
  }

  Future resetPwd() async {
    if (isBusy) return;

    int err = 0;
    if (passwordCtrl.text.isEmpty) err++;
    if (passwordConfirmCtrl.text.isEmpty) err++;
    if (err > 0) return await F.showInfoDialog('Harap semua kolom di isi !');

    if (passwordCtrl.text.trim() != passwordConfirmCtrl.text.trim())
      return await F.showInfoDialog('Konfirmasi Password tidak sama !');

    DialogResponse response =
        await F.showConfirmDialog('Anda yakin ingin me-reset password ?');

    if (response.confirmed) {
      await resetPassword();
    }
  }

  Future resetPassword() async {
    setBusy(true);
    Result _result = await _api.resetPassword(
      otp: otp!,
      password: passwordCtrl.text.trim(),
    );
    setBusy(false);

    if (!_result.status) return await F.showErrorDialog(_result.message!);
    
    await F.showInfoDialog(_result.message!);
    F.back();
  }
}
