import 'package:flutter/material.dart';
import 'package:qonstanta/ui/views/widgets/progress_dialog.dart';
import 'package:get/get.dart';

class ProgressDialogHelper {
  static ProgressDialog? pr;

  static init(BuildContext context) {
    pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
    );
    pr!.style(
      message: 'Please wait...',
      progressWidget: Image.asset('assets/images/loading.gif'),
    );
    return pr;
  }
}

final ProgressDialog progressDialog =
    ProgressDialogHelper.init(Get.key.currentContext!);
