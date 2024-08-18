import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qonstanta/ui/shared/app_bar.dart';
import 'package:qonstanta/ui/shared/ui_helper.dart';
import 'package:qonstanta/ui/views/widgets/countdown_timer.dart';
import 'package:qonstanta/ui/views/widgets/numeric_pad.dart';
import 'package:stacked/stacked.dart';
import 'package:get/get.dart';

import 'otp_viewmodel.dart';

OtpViewModel? _model;

class OtpView extends StatelessWidget {
  const OtpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OtpViewModel>.reactive(
        onModelReady: (model) async {
          _model = model;
        },
        builder: (context, model, child) => MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: Scaffold(
                  appBar: appBar(context, ''),
                  resizeToAvoidBottomInset: false,
                  body: Stack(children: [bg, content])),
            ),
        viewModelBuilder: () => OtpViewModel());
  }

  get bg => Container(color: primaryColor);

  get content => SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  vSpaceXSmall,
                  Text(
                    "otp_title".tr,
                    style: heading2Style,
                  ),
                  Text(
                    "otp_subtitle".trArgs([_model!.otpEmail ?? '-']),
                    style: captionStyle,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 16.0),
                  //   child: RichText(
                  //     text: TextSpan(
                  //       text: 'Kode OTP telah dikirim ke ',
                  //       style: oStyle.clr(Colors.black87),
                  //       children: [
                  //         TextSpan(
                  //           text: '${_model!.otpEmail}',
                  //           style: oStyle.bold,
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  vSpaceXSmall,
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        buildCodeNumberBox(_model!.code.length > 0
                            ? _model!.code.substring(0, 1)
                            : ""),
                        buildCodeNumberBox(_model!.code.length > 1
                            ? _model!.code.substring(1, 2)
                            : ""),
                        buildCodeNumberBox(_model!.code.length > 2
                            ? _model!.code.substring(2, 3)
                            : ""),
                        buildCodeNumberBox(_model!.code.length > 3
                            ? _model!.code.substring(3, 4)
                            : ""),
                      ],
                    ),
                  ),
                  vSpaceXSmall,
                  _model!.hasTimerStopped
                      ? RichText(
                          text: TextSpan(
                            text: 'otp_footer2'.tr,
                            style: captionStyle.clr(oWhite),
                            children: [
                              TextSpan(
                                text: 'otp_resend'.tr,
                                style: captionStyle.clr(linkColor),
                                recognizer: TapGestureRecognizer()
                                  ..onTap =
                                      () async => await _model!.resendOTP(),
                              )
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            Text(
                              'otp_footer'.tr,
                              style: captionStyle.clr(oWhite),
                            ),
                            Container(
                              width: 60.0,
                              padding: EdgeInsets.only(top: 3.0, right: 4.0),
                              child: CountDownTimer(
                                secondsRemaining: 60,
                                whenTimeExpires: () {
                                  _model!.hasTimerStopped = true;
                                  _model!.notifyListeners();
                                },
                                countDownStyle: TextStyle(
                                  color: Color(0XFFf5a623),
                                  fontSize: 17.0,
                                  height: 1.2,
                                ),
                              ),
                            ),
                          ],
                        ),
                  vSpaceSmall,
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  //   child: SizedBox(
                  //     height: 45,
                  //     child: BusyButton(
                  //         title: 'KONFIRMASI OTP !',
                  //         onPressed: () async => await _model!.confirmOTP()),
                  //   ),
                  // ),
                  // vSpaceXSmall(),
                ],
              ),
            ),
            NumericPad(onNumberSelected: _model!.numberPress),
          ],
        ),
      );

  Widget buildCodeNumberBox(String codeNumber) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        width: 60,
        height: 60,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFF6F5FA),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 25.0,
                  spreadRadius: 1,
                  offset: Offset(0.0, 0.75))
            ],
          ),
          child: Center(
            child: Text(
              codeNumber,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F1F1F),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
