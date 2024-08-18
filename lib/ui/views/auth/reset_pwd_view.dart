import 'package:flutter/material.dart';
import 'package:qonstanta/ui/shared/app_bar.dart';
import 'package:qonstanta/ui/shared/ui_helper.dart';
import 'package:qonstanta/ui/views/widgets/busy_button.dart';
import 'package:qonstanta/ui/views/widgets/input_field.dart';
import 'package:stacked/stacked.dart';
import 'package:get/get.dart';

import 'reset_pwd_viewmodel.dart';

ResetPwdViewModel? _model;

class ResetPwdView extends StatelessWidget {
  const ResetPwdView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ResetPwdViewModel>.reactive(
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
        viewModelBuilder: () => ResetPwdViewModel());
  }

  get bg => Container(color: primaryColor);

  get content => SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: screenHeight * 0.05,
              left: screenWidth < 1000 ? 30.0 : 300.0,
              right: screenWidth < 1000 ? 30.0 : 300.0,
            ),
            child: Column(
              children: [
                if (_model!.isBusy) LinearProgressIndicator(),
                vSpaceSmall,
                Text(
                  "reset_pwd_title".tr,
                  style: heading2Style,
                ),
                Text(
                  "reset_pwd_subtitle".tr,
                  style: captionStyle,
                ),
                vSpaceSmall,
                vSpaceSmall,
                InputField(
                  placeholder: 'Password',
                  password: true,
                  icon: iconMask(Icons.lock_outline),
                  fieldFocusNode: _model!.passwordFocus,
                  nextFocusNode: _model!.passwordConfirmFocus,
                  controller: _model!.passwordCtrl,
                  // validator: (val) => val!.isEmpty ? 'Harap di isi !' : null,
                ),
                vSpace(5),
                InputField(
                  placeholder: 'Konfirmasi Password',
                  password: true,
                  icon: iconMask(Icons.lock_outline),
                  fieldFocusNode: _model!.passwordConfirmFocus,
                  textInputAction: TextInputAction.done,
                  controller: _model!.passwordConfirmCtrl,
                  // validator: (val) => val!.isEmpty
                  //     ? 'Harap di isi !'
                  //     : val != _model!.passwordCtrl.text
                  //         ? 'Password konfirmasi tidak sama !'
                  //         : null,
                  enterPressed: () async => await _model!.resetPwd(),
                ),
                vSpaceSmall,
                BusyButton(
                  title: 'reset_pwd_btn'.tr,
                  busy: _model!.isBusy,
                  width: 200,
                  onPressed: () async => await _model!.resetPwd(),
                ),
              ],
            ),
          ),
        ),
      );
}
