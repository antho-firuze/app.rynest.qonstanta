import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qonstanta/api/api_service.dart';
import 'package:qonstanta/app/app.locator.dart';
import 'package:qonstanta/helpers/F.dart';
import 'package:qonstanta/helpers/result.dart';
import 'package:stacked/stacked.dart';

class OtpViewModel extends FutureViewModel {
  String _title = 'Konfirmasi OTP';
  String get title => _title;

  final _api = locator<ApiService>();

  int? otp;
  String? otpEmail;
  String code = '';

  bool hasTimerStopped = false;

  @override
  Future futureToRun() async {
    debugPrint(_title);

    otp = _api.otp;
    otpEmail = _api.otpEmail!.toLowerCase();

    notifyListeners();
  }

  numberPress(int value) {
    if (value != -1) {
      if (code.length < 4) {
        code = code + value.toString();
      }
    } else {
      if (code.length > 0) code = code.substring(0, code.length - 1);
    }
    print(code);
    if (code.length > 3) if (int.parse(code) == otp)
      confirmOTP();
    else
      F.showInfoDialog('OTP anda salah !');

    notifyListeners();
  }

  Future confirmOTP() async {
    if (isBusy) return;

    F.back(result: true);
  }

  Future resendOTP() async {
    if (isBusy) return;

    await forgotPassword();
  }

  Future forgotPassword() async {
    setBusy(true);
    Result _result = await _api.forgotPassword(email: otpEmail!);
    setBusy(false);

    if (!_result.status) return await F.showErrorDialog(_result.message!);

    hasTimerStopped = false;
    otp = _result.data;
    notifyListeners();
  }
}
