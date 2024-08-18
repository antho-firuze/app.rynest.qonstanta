import 'package:flutter/material.dart';
import 'package:qonstanta/ui/shared/app_bar.dart';
import 'package:qonstanta/ui/shared/ui_helper.dart';
import 'package:qonstanta/ui/views/widgets/busy_button.dart';
import 'package:qonstanta/ui/views/widgets/input_field.dart';
import 'package:stacked/stacked.dart';
import 'package:get/get.dart';

import 'change_pwd_viewmodel.dart';

ChangePwdViewModel? _model;

class ChangePwdView extends StatelessWidget {
  const ChangePwdView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChangePwdViewModel>.reactive(
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
        viewModelBuilder: () => ChangePwdViewModel());
  }

  get bg => Container(color: primaryColor);

  get content => SafeArea(
        child: SingleChildScrollView(
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.05,
                left: screenWidth < 1000 ? 30.0 : 300.0,
                right: screenWidth < 1000 ? 30.0 : 300.0,
              ),
              child: Column(
                children: [
                  if (_model!.isBusy) LinearProgressIndicator(),
                  Text(
                    "change_pwd_title".tr,
                    style: heading2Style,
                  ),
                  Text(
                    "change_pwd_subtitle".tr,
                    style: captionStyle,
                  ),
                  vSpaceSmall,
                  vSpaceSmall,
                  InputField(
                    label: 'Password Lama',
                    password: true,
                    icon: iconMask(Icons.lock_outline),
                    fieldFocusNode: _model!.passwordOldFocus,
                    nextFocusNode: _model!.passwordNewFocus,
                    controller: _model!.passwordOldCtrl,
                    // validator: (val) => val!.isEmpty ? 'Harap di isi !' : null,
                  ),
                  vSpace(5),
                  InputField(
                    label: 'Password Baru',
                    password: true,
                    icon: iconMask(Icons.lock_outline),
                    fieldFocusNode: _model!.passwordNewFocus,
                    nextFocusNode: _model!.passwordNewConfirmFocus,
                    controller: _model!.passwordNewCtrl,
                    // validator: (val) => val!.isEmpty ? 'Harap di isi !' : null,
                  ),
                  vSpace(5),
                  InputField(
                    label: 'Konfirmasi Password Baru',
                    password: true,
                    icon: iconMask(Icons.lock_outline),
                    fieldFocusNode: _model!.passwordNewConfirmFocus,
                    textInputAction: TextInputAction.done,
                    controller: _model!.passwordNewConfirmCtrl,
                    validator: (val) => val!.isEmpty
                        ? 'Harap di isi !'
                        : val != _model!.passwordNewCtrl.text
                            ? 'Password konfirmasi tidak sama !'
                            : null,
                    enterPressed: () async => await _model!.updatePassword(),
                  ),
                  vSpaceSmall,
                  BusyButton(
                    title: 'change_pwd_btn'.tr,
                    busy: _model!.isBusy,
                    width: 200,
                    onPressed: () async => await _model!.updatePassword(),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
