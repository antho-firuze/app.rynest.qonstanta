import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qonstanta/app/app.locator.dart';
import 'package:qonstanta/helpers/F.dart';
import 'package:qonstanta/models/profile.dart';
import 'package:qonstanta/services/database_service.dart';
import 'package:qonstanta/services/media_service.dart';
import 'package:qonstanta/ui/views/about/about_view.dart';
import 'package:qonstanta/ui/views/profile/profile_edit_view.dart';
import 'package:qonstanta/ui/views/widgets/image_view.dart';
import 'package:stacked/stacked.dart';

class ProfileViewModel extends FutureViewModel {
  String _title = 'Profil';
  String get title => _title;

  // final _apiMember = locator<ApiMember>();
  final _mediaService = locator<MediaService>();
  final _db = locator<DatabaseService>();

  String? projectVersion;
  Profile profile = Profile().initialize();
  int dummyId = 1;
  bool isBusyUpdatePhoto = false;

  @override
  Future futureToRun() async {
    debugPrint(_title);

    dummyId = Random().nextInt(99999);
    profile = await _db.getProfile();

    projectVersion = await F.version();

    notifyListeners();
  }

  Future onRefresh() async {
    if (isBusy) return;

    setBusy(true);
    await getProfile();
    dummyId++;

    notifyListeners();
    setBusy(false);
  }

  Future getProfile() async {
    // Result result = await _apiMember.getProfile();
    // switch (result.type) {
    //   case ResultType.Success:
    //     return profile = result.data;
    //   case ResultType.Error:
    //     await F.showConnectionErrorDialog(result.message);
    //     await getProfile();
    //     break;
    //   case ResultType.Warning:
    //     if (mustLogin.contains(result.statusCode)) {
    //       if (await _navigation.navigateWithTransition(LoginView(),
    //           transition: 'rightToLeft'))
    //         await getProfile();
    //     }
    // }
  }

  Future getPicture(BuildContext ctx) async {
    if (isBusyUpdatePhoto) return;

    await _mediaService.dialogImageSelector(
        ctx: ctx,
        callback: (pickedImage) async {
          // await _saveProfileImage(pickedImage);
          profile.photoEnc = base64.encode(pickedImage.readAsBytesSync());
          await _db.updateProfile(profile: profile);
          profile = await _db.getProfile();
          notifyListeners();
        },
        withCrop: true);
  }

  logout() async => await F.onLogout();

  contactUs() async => await F.navigateWithTransition(AboutView());

  profileEdit() async {
    if (await F.navigateWithTransition(ProfileEditView())) {
      profile = await _db.getProfile();
      notifyListeners();
    }
  }

  showImage(String image) => F.navigateWithTransition(ImageView(image: image));
}
