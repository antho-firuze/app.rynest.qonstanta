import 'package:flutter/material.dart';
import 'package:qonstanta/api/api_service.dart';
import 'package:qonstanta/app/app.locator.dart';
import 'package:qonstanta/helpers/F.dart';
import 'package:qonstanta/helpers/firestore_helpher.dart';
import 'package:qonstanta/helpers/result.dart';
import 'package:qonstanta/models/user.dart';
import 'package:stacked/stacked.dart';
import 'package:get/get.dart';

class SignupViewModel extends BaseViewModel {
  String _title = 'Sign Up';
  String get title => _title;

  final _api = locator<ApiService>();

  bool _isBusyLoginGoogle = false;
  bool get isBusyLoginGoogle => _isBusyLoginGoogle;
  bool _isBusyLoginApple = false;
  bool get isBusyLoginApple => _isBusyLoginApple;

  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final passwordConfirmCtrl = TextEditingController();
  final fullnameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();

  Future init() async {
    usernameCtrl.text = '';
    passwordCtrl.text = '';
    passwordConfirmCtrl.text = '';
    fullnameCtrl.text = '';
    phoneCtrl.text = '';
    // usernameCtrl.text = 'ahmad.firuze@gmail.com';
    // passwordCtrl.text = '123456';
    // passwordConfirmCtrl.text = '123456';
    // fullnameCtrl.text = 'Ahmad Hertanto';
    // phoneCtrl.text = '085777974703';
  }

  Future register() async {
    if (isBusy) return;

    if (usernameCtrl.text.isEmpty) return F.showInfoDialog('check_username'.tr);
    if (passwordCtrl.text.isEmpty) return F.showInfoDialog('check_password'.tr);
    if (passwordConfirmCtrl.text.isEmpty)
      return F.showInfoDialog('check_password'.tr);
    if (fullnameCtrl.text.isEmpty) return F.showInfoDialog('check_fullname'.tr);
    if (phoneCtrl.text.isEmpty) return F.showInfoDialog('check_phone'.tr);

    setBusy(true);
    Result _result = await _api.signUp(
      username: usernameCtrl.text.trim(),
      password: passwordCtrl.text,
    );
    setBusy(false);

    if (!_result.status) return await F.showErrorDialog(_result.message!);

    // WRITE
    F.log.i(_result.data);
    var data = _result.data;
    User user = User(
      email: data.email,
      fullName: fullnameCtrl.text,
      phone: phoneCtrl.text,
      role: ['user'],
    );
    await firestoreCollection.users.doc(data.uid).set(user.toJson());

    await F.showInfoDialog(_result.message!);
    F.back(result: true);
  }

  showAbout() async {
    // F.navigateWithTransition(AboutView());
  }

  screenLogin() {
    F.back();
  }
}
