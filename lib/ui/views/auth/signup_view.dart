import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qonstanta/helpers/F.dart';
import 'package:qonstanta/ui/shared/app_bar.dart';
import 'package:qonstanta/ui/shared/ui_helper.dart';
import 'package:qonstanta/ui/views/widgets/busy_button.dart';
import 'package:qonstanta/ui/views/widgets/input_field.dart';
import 'package:stacked/stacked.dart';
import 'package:get/get.dart';

import 'signup_viewmodel.dart';

var _model = SignupViewModel();

final FocusNode _usernameFocus = FocusNode();
final FocusNode _passwordFocus = FocusNode();
final FocusNode _passwordConfirmFocus = FocusNode();
final FocusNode _fullnameFocus = FocusNode();
final FocusNode _phoneFocus = FocusNode();

class SignupView extends StatelessWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignupViewModel>.reactive(
        onModelReady: (model) async {
          _model = model;
          await _model.init();
        },
        builder: (context, model, child) => MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: Scaffold(
                appBar: appBar(context, ''),
                backgroundColor: Colors.transparent,
                resizeToAvoidBottomInset: true,
                body: Stack(children: [bg, content]),
              ),
            ),
        viewModelBuilder: () => SignupViewModel());
  }

  get bg => Container(color: primaryColor);

  get content => SafeArea(
        child: SingleChildScrollView(
          child: sectionForm,
        ),
      );

  get sectionForm => Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.only(
            top: screenHeight * 0.05,
            left: screenWidth < 1000 ? 30.0 : 300.0,
            right: screenWidth < 1000 ? 30.0 : 300.0,
          ),
          child: Column(
            children: [
              Text(
                "signup_title".tr,
                style: heading2Style,
              ),
              Text(
                "signup_subtitle".tr,
                style: captionStyle,
              ),
              vSpaceSmall,
              Column(
                children: [
                  InputField(
                    controller: _model.usernameCtrl,
                    fieldFocusNode: _usernameFocus,
                    nextFocusNode: _passwordFocus,
                    placeholder: "Email",
                    icon: iconMask(Icons.mail_outline),
                    onChanged: (val) => _model.notifyListeners(),
                    // validator: (val) => _model.usernameCtrl.text.isEmpty
                    //     ? 'required'.tr
                    //     : null,
                  ),
                  vSpace(5),
                  InputField(
                    controller: _model.passwordCtrl,
                    fieldFocusNode: _passwordFocus,
                    nextFocusNode: _passwordConfirmFocus,
                    placeholder: "Password",
                    icon: iconMask(Icons.lock_outline),
                    password: true,
                    onChanged: (val) => _model.notifyListeners(),
                    // validator: (val) => _model.passwordCtrl.text.isEmpty
                    //     ? 'required'.tr
                    //     : null,
                  ),
                  vSpace(5),
                  InputField(
                    controller: _model.passwordConfirmCtrl,
                    fieldFocusNode: _passwordConfirmFocus,
                    nextFocusNode: _fullnameFocus,
                    placeholder: "password_confirm".tr,
                    icon: iconMask(Icons.lock_outline),
                    password: true,
                    onChanged: (val) => _model.notifyListeners(),
                    // validator: (val) =>
                    //     _model.passwordConfirmCtrl.text.isEmpty
                    //         ? 'required'.tr
                    //         : _model.passwordCtrl.text !=
                    //                 _model.passwordConfirmCtrl.text
                    //             ? 'password_confirm-not-match'.tr
                    //             : null,
                  ),
                  vSpace(5),
                  InputField(
                    controller: _model.fullnameCtrl,
                    fieldFocusNode: _fullnameFocus,
                    nextFocusNode: _phoneFocus,
                    placeholder: "fullname".tr,
                    icon: iconMask(Icons.person_outline),
                    onChanged: (val) => _model.notifyListeners(),
                    // validator: (val) => _model.fullnameCtrl.text.isEmpty
                    //     ? 'required'.tr
                    //     : null,
                  ),
                  vSpace(5),
                  InputField(
                    controller: _model.phoneCtrl,
                    fieldFocusNode: _phoneFocus,
                    placeholder: "phone".tr,
                    icon: iconFaMask(FontAwesomeIcons.whatsapp),
                    textInputAction: TextInputAction.done,
                    enterPressed: () async => await _model.register(),
                    onChanged: (val) => _model.notifyListeners(),
                    // validator: (val) => _model.phoneCtrl.text.isEmpty
                    //     ? 'required'.tr
                    //     : null,
                  ),
                  vSpaceSmall,
                  BusyButton(
                    title: 'signup_btn'.tr,
                    busy: _model.isBusy,
                    width: 200,
                    onPressed: () async => await _model.register(),
                  ),
                  vSpaceSmall,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'have_account'.tr,
                        style: captionStyle.clr(oWhite),
                      ),
                      InkWell(
                          onTap: () => _model.screenLogin(),
                          child: Text(
                            'here'.tr,
                            style: captionStyle.clr(linkColor).bold,
                          )),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      );
}
