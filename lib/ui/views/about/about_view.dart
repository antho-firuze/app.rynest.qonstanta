import 'package:flutter/material.dart';
import 'package:qonstanta/ui/shared/app_bar.dart';
import 'package:qonstanta/ui/shared/ui_helper.dart';
import 'package:qonstanta/ui/views/widgets/text_link.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qonstanta/helpers/extensions.dart';

import 'about_viewmodel.dart';

AboutViewModel? _model;

class AboutView extends StatelessWidget {
  const AboutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AboutViewModel>.reactive(
        onModelReady: (model) async {
          _model = model;
        },
        builder: (context, model, child) => Scaffold(
            appBar: appBar(context, _model!.title),
            resizeToAvoidBottomInset: false,
            body: Stack(children: [bg, content])),
        viewModelBuilder: () => AboutViewModel());
  }

  get bg => Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background_a.png'),
                fit: BoxFit.cover)),
      );

  get content => Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      'assets/images/logo_01.png',
                      width: 150,
                      height: 100,
                    )),
                vSpaceXSmall,
                Text(
                  'NUR ADEN',
                  style: oStyle.bold.size(22),
                ),
                Text(
                  'ISLAMIC BOARDING SCHOOL',
                  style: oStyle.bold.size(22),
                ),
                vSpaceXSmall,
                Text(
                  'Jl. Raya Veteran 3 Tapos, RT 002/003 Kampung Pondok Menteng \n'
                  'Kel. Citapen – Kec. Ciawi, Kab. Bogor 16720 \nJawa barat - Indonesia',
                  textAlign: TextAlign.center,
                  style: oStyle.bold,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextLink('+622518293148'.formatPSTNNumber(),
                        onPressed: () => launch('tel:+622518293148')),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text('&'),
                    ),
                    TextLink('+622518293149'.formatPSTNNumber(),
                        onPressed: () => launch('tel:+622518293149')),
                  ],
                ),
                vSpaceSmall,
              ],
            ),
          ),
        ),
      );
}
