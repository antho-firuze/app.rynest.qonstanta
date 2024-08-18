import 'package:flutter/material.dart';
import 'package:qonstanta/helpers/F.dart';
import 'package:qonstanta/ui/shared/ui_helper.dart';
import 'package:qonstanta/ui/views/widgets/busy_button.dart';
import 'package:qonstanta/ui/views/widgets/input_field.dart';
import 'package:stacked/stacked.dart';
import 'package:get/get.dart';

import 'signin_viewmodel.dart';

var _model = SigninViewModel();

class SigninView extends StatelessWidget {
  const SigninView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await F.onWillPop(),
      child: ViewModelBuilder<SigninViewModel>.reactive(
          onModelReady: (model) async {
            _model = model;
            await _model.init();
          },
          builder: (context, model, child) => MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Stack(children: [bg, content]),
                ),
              ),
          viewModelBuilder: () => SigninViewModel()),
    );
  }

  get bg => Container(color: primaryColor);

  get content => Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: sectionForm,
        ),
      );

  get sectionForm => Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.only(
            top: screenHeight * 0.2,
            left: screenWidth < 1000 ? 30.0 : 300.0,
            right: screenWidth < 1000 ? 30.0 : 300.0,
          ),
          child: Column(
            children: [
              Text(
                "signin_title".tr,
                style: heading2Style,
              ),
              Text(
                "signin_subtitle".tr,
                style: captionStyle,
              ),
              vSpaceSmall,
              screenHeight > 690 ? vSpaceSmall : vSpaceXSmall,
              InputField(
                label: "username".tr,
                controller: _model.usernameCtrl,
                fieldFocusNode: _model.usernameFocus,
                nextFocusNode: _model.passwordFocus,
                placeholder: "username".tr,
                icon: iconMask(Icons.mail_outline),
              ),
              vSpaceXSmall,
              InputField(
                label: "Password",
                controller: _model.passwordCtrl,
                fieldFocusNode: _model.passwordFocus,
                textInputAction: TextInputAction.done,
                placeholder: "Password",
                icon: iconMask(Icons.lock_outline),
                password: true,
                enterPressed: () async => await _model.signIn(),
              ),
              vSpaceXSmall,
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () => _model.screenForgotPwd(),
                  child: Text(
                    "forgot_password".tr,
                    style: captionStyle.clr(linkColor),
                  ),
                ),
              ),
              vSpaceSmall,
              BusyButton(
                title: 'signin_btn'.tr,
                busy: _model.isBusy,
                onPressed: () async => await _model.signIn(),
              ),
              vSpaceSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('not_have_account'.tr, style: captionStyle.clr(oWhite)),
                  InkWell(
                    onTap: () => _model.screenSignup(),
                    child: Text(
                      'here'.tr,
                      style: captionStyle.clr(linkColor).bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
