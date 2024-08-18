import 'package:flutter/material.dart';
import 'package:qonstanta/ui/shared/app_bar.dart';
import 'package:qonstanta/ui/shared/ui_helper.dart';
import 'package:qonstanta/ui/views/widgets/busy_button.dart';
import 'package:qonstanta/ui/views/widgets/input_field.dart';
import 'package:stacked/stacked.dart';
import 'package:get/get.dart';

import 'forgot_pwd_viewmodel.dart';

ForgotPwdViewModel? _model;

class ForgotPwdView extends StatelessWidget {
  const ForgotPwdView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ForgotPwdViewModel>.reactive(
        onModelReady: (model) async {
          _model = model;
        },
        builder: (context, model, child) => MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: Scaffold(
                  appBar: appBar(context, ''),
                  resizeToAvoidBottomInset: true,
                  body: Stack(children: [bg, content])),
            ),
        viewModelBuilder: () => ForgotPwdViewModel());
  }

  get bg => Container(color: primaryColor);

  get content => SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: screenHeight * 0.1,
              left: screenWidth < 1000 ? 30.0 : 300.0,
              right: screenWidth < 1000 ? 30.0 : 300.0,
            ),
            child: Column(
              children: [
                if (_model!.isBusy) LinearProgressIndicator(),
                vSpaceSmall,
                Text(
                  'forgot_pwd_title'.tr,
                  textAlign: TextAlign.center,
                  style: heading2Style,
                ),
                Text(
                  'forgot_pwd_subtitle'.tr,
                  textAlign: TextAlign.center,
                  style: captionStyle,
                ),
                vSpaceSmall,
                InputField(
                  icon: iconMask(Icons.mail_outline),
                  textInputAction: TextInputAction.done,
                  controller: _model!.emailCtrl,
                  // validator: (val) => val!.isEmpty ? 'required'.tr : null,
                  enterPressed: () async => await _model!.sendOTP(),
                ),
                vSpaceSmall,
                BusyButton(
                  title: 'forgot_pwd-btn'.tr,
                  busy: _model!.isBusy,
                  onPressed: () async => await _model!.sendOTP(),
                ),
              ],
            ),
          ),
        ),
      );
}
