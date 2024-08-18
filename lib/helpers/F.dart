import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qonstanta/app/app.locator.dart';
import 'package:qonstanta/enums/basic_dialog_status.dart';
import 'package:qonstanta/enums/dialog_type.dart';
import 'package:qonstanta/helpers/result.dart';
import 'package:qonstanta/services/fcm_service.dart';
import 'package:qonstanta/services/session_service.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:qonstanta/ui/shared/ui_helper.dart';
import 'package:qonstanta/ui/views/auth/signin_view.dart';
import 'package:qonstanta/ui/views/startup/startup_view.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:intl/intl.dart';

class Ff {
  final _dialog = locator<DialogService>();
  final _snack = locator<SnackbarService>();
  final session = locator<SessionService>();
  final _pusher = locator<FcmService>();

  bool isBusy = false;
  BuildContext? _dismissingContext;

  final log = Logger();

  int rndNum() => Random().nextInt(99999);
  String currDT() => DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  String currDate() => DateFormat('yyyy-MM-dd').format(DateTime.now());
  String currTime() => DateFormat('HH:mm:ss').format(DateTime.now());

  String agent = Platform.isAndroid
      ? 'android'
      : Platform.isIOS
          ? 'ios'
          : 'web';

  // Convert List<int> to String of Decimal 10 digits
  String lintToString(List<int> lint) {
    return hexToInt(lintToHex(lint)).toString().padLeft(10, '0');
  }

  // Convert List<int> to Hexadecimal value
  String lintToHex(List<int> lint) {
    return lint.reversed
        .map((e) => e.toRadixString(16).padLeft(2, '0'))
        .join('');
  }

  // Convert Hexadecimal to Integer/Decimal value
  int hexToInt(String hex) {
    int val = 0;
    int len = hex.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = hex.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw new FormatException("Invalid hexadecimal value");
      }
    }
    return val;
  }

  Future wait({int? seconds}) async =>
      await Future.delayed(Duration(seconds: seconds ?? 1));

  void exzit() {
    SystemNavigator.pop();
    exit(0);
  }

  onApiRequestError(
      {required Result result, required Function callback}) async {
    await F.showErrorDialog(result.message!);

    if (result.errCode == '9000')
      return await F.onDoubleLogin(callback: callback);

    if (result.errCode == '999999999')
      return await F.onNetworkError(callback: callback);
  }

  onNetworkError({required Function callback}) async {
    DialogResponse _dlg = await F.showConfirmDialog('do-you-want-try-again'.tr);
    if (_dlg.confirmed) return await callback();

    exzit();
  }

  onDoubleLogin({required Function callback}) async {
    DialogResponse _dlg = await F.showConfirmDialog('please-re-login'.tr);
    if (_dlg.confirmed) if (await F.navigateWithTransition(SigninView()))
      return await callback();

    exzit();
  }

  onForceToLogin() async {
    await _pusher.unsubs.signIn();
    F.session.clearPreferences();

    String _msg1 = 'another-login-device'.trArgs([F.agent]);
    String _msg2 = 'do-you-want-re-login'.tr;
    DialogResponse _dlg = await F.showConfirmDialog("$_msg1\n$_msg2");
    if (_dlg.confirmed) return await F.navigateWithTransition(SigninView());

    exzit();
  }

  onLogout() async {
    DialogResponse _dlg = await F.showConfirmDialog('do-you-want-logout'.tr);
    if (_dlg.confirmed) {
      await _pusher.unsubs.signIn();
      F.session.clearPreferences();
      await F.replaceWithTransition(StartUpView());
    }
  }

  Future<bool> onWillPop() async {
    DialogResponse _dlg = await showConfirmDialog('do-you-want-quit'.tr);
    if (_dlg.confirmed) exzit();

    return false;
  }

  // Package Info
  Future<String> version() async {
    PackageInfo _info = await PackageInfo.fromPlatform();

    return _info.version;
  }

  Future<String?> deviceId() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      return androidInfo.androidId;
    }
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
      return iosInfo.identifierForVendor;
    }

    return "${F.rndNum()}-${F.rndNum()}-${F.rndNum()}";
  }

  int compareVersionName({required String currVer, required String lastVer}) {
    List<String> cVer = currVer.split(".");
    List<String> rVer = lastVer.split(".");
    int maxIndex = max(rVer.length, cVer.length);

    var result = 0;
    for (var i = 0; i < maxIndex; i++) {
      if (int.parse(cVer[i]) < int.parse(rVer[i])) {
        result = -1;
        break;
      } else if (int.parse(cVer[i]) > int.parse(rVer[i])) {
        result = 1;
        break;
      }
    }

    if (result == 0 && cVer.length != rVer.length) {
      result = cVer.length > rVer.length ? 1 : -1;
    }
    return result;
  }

  // NAVIGATION SECTION =============

  Future<T?>? replaceWithTransition<T>(Widget page,
          {Transition? trans, dynamic arguments, int? id}) async =>
      await Get.off(
        page,
        arguments: arguments,
        id: id,
        transition: trans ?? Transition.rightToLeft,
      );

  Future<T?>? navigateWithTransition<T>(Widget page,
          {Transition? trans, dynamic arguments, int? id}) async =>
      await Get.to(
        page,
        arguments: arguments,
        id: id,
        transition: trans ?? Transition.rightToLeft,
      );

  bool back<T>({T? result, int? id}) {
    Get.back<T>(result: result, id: id);
    return Get.key.currentState?.canPop() ?? false;
  }

  // SNACKBAR, DIALOG & PROGRESS DIALOG SECTION ==============

  setBuzy(bool value) async {
    isBusy = value;
    if (value) {
      await showDialog(
        context: Get.key.currentContext!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          _dismissingContext = context;
          return WillPopScope(
            onWillPop: () async => false,
            child: Dialog(
              backgroundColor: primaryColor,
              insetAnimationCurve: Curves.easeInOut,
              insetAnimationDuration: Duration(milliseconds: 100),
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const SizedBox(width: 8.0),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            width: 60.0,
                            height: 60.0,
                            child: Image.asset('assets/images/loading.gif'),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Text(
                            'Please wait..',
                            textAlign: TextAlign.left,
                            style: heading2Style,
                          ),
                        ),
                        const SizedBox(width: 8.0)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } else {
      Navigator.of(_dismissingContext!).pop();
    }
  }

  showSnackbar(String message, {String? title, int duration = 3}) {
    // Get.snackbar(
    //   title ?? '',
    //   message,
    //   titleText: SizedBox.shrink(),
    //   duration: Duration(seconds: duration),
    //   snackPosition: SnackPosition.BOTTOM,
    //   margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
    // );
    _snack.showSnackbar(
      message: message,
      duration: Duration(seconds: duration),
    );
  }

  showErrorSnackbar(String message, {String? title, int duration = 3}) {
    // Get.snackbar(
    //   title ?? 'error'.tr,
    //   message,
    //   duration: Duration(seconds: duration),
    //   snackPosition: SnackPosition.BOTTOM,
    // );
    _snack.showSnackbar(
      message: message,
      title: title ?? 'error'.tr,
      duration: Duration(seconds: duration),
    );
  }

  showErrorDialog(String message, {String? title, String? btnTitle}) async {
    DialogResponse? response = await _dialog.showCustomDialog(
      title: title ?? 'error'.tr,
      description: message,
      variant: DialogType.basic,
      data: BasicDialogStatus.error,
      mainButtonTitle: btnTitle ?? 'close'.tr,
    );
    return response;
  }

  showWarningDialog(String message, {String? title, String? okTitle}) async {
    await _dialog.showCustomDialog(
      title: title ?? 'info'.tr,
      description: message,
      variant: DialogType.basic,
      data: BasicDialogStatus.warning,
      mainButtonTitle: okTitle ?? 'ok'.tr,
    );
  }

  showInfoDialog(String message, {String? title, String? okTitle}) async {
    await _dialog.showCustomDialog(
      title: title ?? 'info'.tr,
      description: message,
      variant: DialogType.basic,
      data: BasicDialogStatus.info,
      mainButtonTitle: okTitle ?? 'ok'.tr,
    );
  }

  showConfirmDialog(
    String message, {
    String? title,
    String? yesTitle,
    String? noTitle,
  }) async {
    DialogResponse? response = await _dialog.showCustomDialog(
      title: title ?? 'confirm'.tr,
      description: message,
      variant: DialogType.basic,
      data: BasicDialogStatus.question,
      mainButtonTitle: yesTitle ?? 'yes'.tr,
      secondaryButtonTitle: noTitle ?? 'no'.tr,
    );

    return response;
  }

  showErrorDialog2(String message,
      {String? title, String? btnTitle, String? btnTitle2}) async {
    DialogResponse? response = await _dialog.showCustomDialog(
      title: title ?? 'error'.tr,
      description: message,
      variant: DialogType.basic,
      data: BasicDialogStatus.error,
      mainButtonTitle: btnTitle ?? 'close'.tr,
      secondaryButtonTitle: btnTitle2 ?? 'retry'.tr,
    );
    return response;
  }

  Future<File> writeToFile(Uint8List data, {required String fileName}) async {
    var bytes = ByteData.sublistView(data);
    final buffer = bytes.buffer;
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath = tempPath + '/$fileName';
    return new File(filePath).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }
}

final F = Ff();
