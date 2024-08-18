import 'package:flutter/material.dart';
import 'package:qonstanta/constants/strings.dart';
import 'package:qonstanta/ui/shared/app_bar.dart';
import 'package:qonstanta/ui/shared/ui_helper.dart';
import 'package:qonstanta/ui/views/widgets/icon_button_camera.dart';
import 'package:qonstanta/ui/views/widgets/list_menu.dart';
import 'package:qonstanta/ui/views/widgets/profile_pic.dart';
import 'package:qonstanta/ui/views/widgets/show_bottom_slide.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qonstanta/helpers/extensions.dart';

import 'profile_viewmodel.dart';

BuildContext? _context;
ProfileViewModel? _model;

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
        onModelReady: (model) async {
          _context = context;
          _model = model;
        },
        builder: (context, model, child) => Scaffold(
              appBar: appBar(context, _model!.title, showBack: false),
              resizeToAvoidBottomInset: false,
              backgroundColor: Theme.of(context).backgroundColor,
              body: Stack(children: [content]),
            ),
        viewModelBuilder: () => ProfileViewModel());
  }

  // get bg => Container(
  //       decoration: BoxDecoration(
  //           image: DecorationImage(
  //               image: AssetImage('assets/images/background_e.png'),
  //               fit: BoxFit.cover)),
  //     );

  get content => SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: [
                Container(
                  height: 115,
                  width: 115,
                  child: Stack(
                    fit: StackFit.expand,
                    clipBehavior: Clip.hardEdge,
                    children: [
                      _model!.isBusyUpdatePhoto
                          ? CircularProgressIndicator()
                          : [null, ''].contains(_model!.profile.photoEnc)
                              ? CircleAvatar(
                                  child: Text(
                                    _model!.profile.fullName!.getInitial(),
                                    style:
                                        TextStyle().size(40).clr(Colors.white),
                                  ),
                                )
                              : InkWell(
                                  onTap: () => _model!
                                      .showImage(_model!.profile.photoEnc!),
                                  child: ProfilePic(
                                    image: _model!.profile.photoEnc,
                                  ),
                                ),
                      Positioned(
                        bottom: 0,
                        right: -10,
                        child: IconButtonCamera(
                          onPressed: () async =>
                              await _model!.getPicture(_context!),
                        ),
                      ),
                    ],
                  ),
                ),
                vSpaceXSmall,
                Text(
                  _model!.profile.fullName!,
                  style:
                      oStyle.size(16).bold.clr(Theme.of(_context!).accentColor),
                ),
                Text(
                  _model!.profile.email!,
                  style: oStyle.size(14).clr(primaryColor),
                ),
                vSpaceSmall,
                ListMenu(
                  text: 'Ubah Profil',
                  icon: Icons.account_circle_outlined,
                  onPressed: () => _model!.profileEdit(),
                ),
                // ProfileMenu(
                //   text: 'Ubah Password',
                //   icon: Icons.vpn_key,
                //   onPressed: () {},
                // ),
                // ProfileMenu(
                //   text: 'Ubah Bahasa',
                //   icon: Icons.flag_outlined,
                //   onPressed: () {},
                // ),
                ListMenu(
                  text: 'Hubungi Kami',
                  icon: Icons.contact_support,
                  onPressed: () async => await _model!.contactUs(),
                ),
                // ProfileMenu(
                //   text: 'Lapor',
                //   icon: Icons.report,
                //   onPressed: () {},
                // ),
                ListMenu(
                  text: 'Tentang Aplikasi',
                  icon: Icons.apps,
                  onPressed: () async => showBottomSlide(
                    context: _context!,
                    title: 'Tentang Aplikasi',
                    maxSize: 0.75,
                    movable: true,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            Text(
                              kAppName,
                              style: oStyle.size(20),
                            ),
                            Text(
                              'v ${_model!.projectVersion}',
                              style: oStyle.size(14).bold,
                            ),
                            vSpaceXSmall,
                            // Image.asset(
                            //   'assets/images/icon_lsp.png',
                            //   height: 100,
                            // ),
                            // vSpaceXSmall,
                            Text(
                              kAbout,
                              textAlign: TextAlign.center,
                            ),
                            vSpaceMedium,
                            Text(
                              '\u00a9 2019-2020 Rynest Technology Indomedia',
                              style: oStyle.size(14),
                            ),
                            Text(
                              'Kota Depok - Jawa Barat, Indonesia',
                              style: oStyle.size(12),
                            ),
                            // vSpaceMedium,
                            // BusyButton(
                            //     title: 'Cek Versi Terbaru',
                            //     onPressed: () => launch(
                            //         'https://play.google.com/store/apps/details?id=com.corewell.lsp')),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                ListMenu(
                  text: 'Kebijakan Privasi',
                  icon: Icons.security,
                  onPressed: () =>
                      launch('https://lsp-ps.id/home/privacypolice'),
                ),
                ListMenu(
                  text: 'Keluar / Logout',
                  icon: Icons.logout,
                  onPressed: () => _model!.logout(),
                ),
                Text(
                  'Versi : ${_model!.projectVersion}',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                vSpaceMedium,
              ],
            ),
          ),
        ),
      );
}
