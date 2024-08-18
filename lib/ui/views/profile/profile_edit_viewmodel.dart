import 'package:flutter/material.dart';
import 'package:qonstanta/app/app.locator.dart';
import 'package:qonstanta/helpers/F.dart';
import 'package:qonstanta/helpers/result.dart';
import 'package:qonstanta/models/profile.dart';
import 'package:qonstanta/services/database_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:get/get.dart';
import 'package:qonstanta/helpers/extensions.dart';

class ProfileEditViewModel extends FutureViewModel {
  String _title = 'Edit Profil';
  String get title => _title;

  // final _navigation = locator<NavigationService>();
  final _db = locator<DatabaseService>();

  Profile profile = Profile().initialize();
  final fullnameCtrl = TextEditingController();
  final placeOfBirthCtrl = TextEditingController();
  final dateOfBirthCtrl = TextEditingController();
  final genderCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  DateTime? dateOfBirth;

  @override
  Future futureToRun() async {
    debugPrint(_title);

    profile = await _db.getProfile();
    fullnameCtrl.text = profile.fullName!;
    placeOfBirthCtrl.text = profile.placeOfBirth ?? '';
    dateOfBirthCtrl.text = profile.dateOfBirth == null
        ? ''
        : profile.dateOfBirth!.asFormatDBDate();
    genderCtrl.text = profile.gender!;
    phoneCtrl.text = profile.phone!;
    emailCtrl.text = profile.email!;

    notifyListeners();
  }

  Future updateProfile() async {
    if (isBusy) return;

    DialogResponse response =
        await F.showConfirmDialog('Anda yakin ingin merubah data ?');

    if (!response.confirmed) return;

    profile.fullName = fullnameCtrl.text;
    profile.email = emailCtrl.text;
    profile.gender = genderCtrl.text;
    profile.phone = phoneCtrl.text;
    profile.dateOfBirth = dateOfBirth;
    profile.placeOfBirth = placeOfBirthCtrl.text;

    setBusy(true);
    Result result = await _db.updateProfile(profile: profile);
    setBusy(false);

    if (!result.status) return await F.showInfoDialog(result.message!);

    await F.showInfoDialog(result.message!);
    F.back(result: true);
  }

  Future setProfile() async {
    // setBusy(true);
    // Result result = await _apiMember.profileEdit(profile);
    // setBusy(false);

    // switch (result.type) {
    //   case ResultType.Success:
    //     await F.showInfoDialog(result.message);
    //     break;
    //   case ResultType.Error:
    //     await F.showConnectionErrorDialog(result.message);
    //     await setProfile();
    //     break;
    //   case ResultType.Warning:
    //     if (mustLogin.contains(result.statusCode)) {
    //       if (await _navigation.navigateWithTransition(LoginView(),
    //           transition: 'rightToLeft')) await setProfile();
    //     }
    // }
  }

  getDate() async {
    DateTime? _datePicked = await showDatePicker(
      context: Get.key.currentContext!,
      initialDate: dateOfBirth ?? DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 70),
      lastDate: DateTime.now(),
    );
    if (_datePicked != null) {
      dateOfBirth = _datePicked;
      dateOfBirthCtrl.text = _datePicked.asFormatDBDate();
      notifyListeners();
    }
  }
}
