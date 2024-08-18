import 'package:flutter/material.dart';
import 'package:qonstanta/constants/api_config.dart';
import 'package:qonstanta/ui/shared/ui_helper.dart';
import 'package:stacked/stacked.dart';

import 'startup_viewmodel.dart';

class StartUpView extends StatelessWidget {
  const StartUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUpViewModel>.nonReactive(
        builder: (context, model, child) => MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: Stack(children: [bg, bgGradient, content])),
            ),
        viewModelBuilder: () => StartUpViewModel());
  }

  get bg => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bg-startup.png'),
              fit: BoxFit.cover),
        ),
      );

  get bgGradient => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.transparent, primaryColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
      );

  get content => Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('Qonstanta', style: heading2Style),
              vSpaceXSmall,
              SizedBox(
                width: safeBlockHorizontal * 60,
                child: LinearProgressIndicator(
                  backgroundColor: primaryColor,
                  color: secondaryColor,
                ),
              ),
              vSpaceXSmall,
              Opacity(
                opacity: 0.25,
                child: Text(
                  endPointUrl,
                  style: oStyle.italic.clr(secondaryColor),
                ),
              ),
            ],
          ),
        ),
      );
}
