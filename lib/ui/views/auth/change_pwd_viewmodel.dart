import 'package:flutter/material.dart';
import 'package:qonstanta/api/api_service.dart';
import 'package:qonstanta/app/app.locator.dart';
import 'package:qonstanta/helpers/F.dart';
import 'package:qonstanta/helpers/result.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ChangePwdViewModel extends FutureViewModel {
  String _title = 'Ubah Password';
  String get title => _title;

  final _api = locator<ApiService>();

  final passwordOldCtrl = TextEditingController();
  final passwordNewCtrl = TextEditingController();
  final passwordNewConfirmCtrl = TextEditingController();
  final passwordOldFocus = FocusNode();
  final passwordNewFocus = FocusNode();
  final passwordNewConfirmFocus = FocusNode();

  @override
  Future futureToRun() async {
    debugPrint(_title);

    notifyListeners();
  }

  Future updatePassword() async {
    if (isBusy) return;

    int err = 0;
    if (passwordOldCtrl.text.isEmpty) err++;
    if (passwordNewCtrl.text.isEmpty) err++;
    if (passwordNewConfirmCtrl.text.isEmpty) err++;
    if (err > 0) return await F.showInfoDialog('Harap semua kolom di isi !');

    if (passwordOldCtrl.text.trim() == passwordNewCtrl.text.trim())
      return await F.showInfoDialog(
          'Password baru anda tidak boleh sama dengan password lama !');

    if (passwordNewCtrl.text.trim() != passwordNewConfirmCtrl.text.trim())
      return await F.showInfoDialog(
          'Konfirmasi Password harus sama dengan password baru !');

    DialogResponse response =
        await F.showConfirmDialog('Anda yakin ingin merubah data ?');

    if (response.confirmed) {
      await changePassword();
    }
  }

  Future changePassword() async {
    setBusy(true);
    Result _result = await _api.changePassword(
      password: passwordOldCtrl.text.trim(),
      newPassword: passwordNewCtrl.text.trim(),
    );
    setBusy(false);

    if (!_result.status) return await F.showErrorDialog(_result.message!);

    await F.showInfoDialog(_result.message!);
    F.back();
  }
}
