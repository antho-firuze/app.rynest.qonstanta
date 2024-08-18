import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qonstanta/api/api_service.dart';
import 'package:qonstanta/app/app.locator.dart';
import 'package:qonstanta/helpers/F.dart';
import 'package:qonstanta/helpers/firebase_auth_helper.dart';
import 'package:qonstanta/helpers/firestore_helpher.dart';
import 'package:qonstanta/helpers/result.dart';
import 'package:qonstanta/models/user.dart';
import 'package:qonstanta/services/fcm_service.dart';
import 'package:qonstanta/ui/views/auth/forgot_pwd_view.dart';
import 'package:qonstanta/ui/views/auth/signup_view.dart';
import 'package:stacked/stacked.dart';
import 'package:get/get.dart';

class SigninViewModel extends BaseViewModel {
  String _title = 'Sign In';
  String get title => _title;

  final _api = locator<ApiService>();
  final _pusher = locator<FcmService>();

  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final usernameFocus = FocusNode();
  final passwordFocus = FocusNode();

  Future init() async {
    usernameCtrl.text = '';
    passwordCtrl.text = '';
    // usernameCtrl.text = 'antho.firuze@gmail.com';
    // passwordCtrl.text = '123456';
  }

  Future signIn() async {
    if (isBusy) return;

    if (usernameCtrl.text.isEmpty && passwordCtrl.text.isEmpty)
      return F.showErrorDialog('check_username_password'.tr);
    if (usernameCtrl.text.isEmpty)
      return F.showErrorDialog('check_username'.tr);
    if (passwordCtrl.text.isEmpty)
      return F.showErrorDialog('check_password'.tr);

    setBusy(true);
    Result _result = await _api.signIn(
      username: usernameCtrl.text.trim(),
      password: passwordCtrl.text,
    );
    setBusy(false);

    if (!_result.status) return await F.showErrorDialog(_result.message!);

    // String id = _result.data.uid;
    // String id = 'RB9Dpsl1RfeNgm3Z32qCUITTyOf2';

    // GET DATA FROM FIRESTORE
    // Result result = await firestoreHelper.getUser(id);
    // if (!result.status) return await F.showErrorDialog(result.message!);

    // if (result.data == null) return await F.showInfoDialog(result.message!);

    // User user = result.data;
    // F.log.i(user.toJson());

    F.log.i(_result.data);

    // SAVE USER & TOKEN TO SESSION
    await F.session.token(value: _result.data);
    var _username = usernameCtrl.text
        .trim()
        .replaceAll(RegExp(r'[!@#$%^&*(),.?":{}|<>]'), '');
    await F.session.signInTopic(value: 'auth~$_username~${F.agent}');

    // PUSHER
    await _pusher.pubs.signIn();
    await _pusher.subs.signIn();

    F.back(result: true);
    await Future.delayed(const Duration(seconds: 2));
    F.showSnackbar('Login berhasil');
  }

  showAbout() async {
    // F.navigateWithTransition(AboutView());
  }

  Future loginWithGoogle() async {
    await F.navigateWithTransition(SignupView());

    // if (_isBusyLoginGoogle) return;

    // _isBusyLoginGoogle = true;

    // Result result = await _signin.googleLogin();
    // switch (result.type) {
    //   case ResultType.Success:
    //     F.back(result: true);
    //     break;
    //   case ResultType.Warning:
    //     await F.showInfoDialog(result.message);
    //     break;
    //   case ResultType.Error:
    //     await F.showConnectionErrorDialog(result.message);
    //     await loginWithGoogle();
    // }
    // _isBusyLoginGoogle = false;
  }

  Future loginWithApple() async {
    // if (_isBusyLoginApple) return;

    // _isBusyLoginApple = true;

    // Result result = await _signin.appleLogin();
    // switch (result.type) {
    //   case ResultType.Success:
    //   case ResultType.Warning:
    //     F.back(result: true);
    //     break;
    //   case ResultType.Error:
    //     await F.showConnectionErrorDialog(result.message);
    //     await loginWithApple();
    // }
    // _isBusyLoginApple = false;
  }

  screenSignup() async => await F.navigateWithTransition(SignupView());

  screenForgotPwd() => F.navigateWithTransition(ForgotPwdView());
}
