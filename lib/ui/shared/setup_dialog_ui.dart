import 'package:flutter/material.dart';
import 'package:qonstanta/app/app.locator.dart';
import 'package:qonstanta/enums/dialog_type.dart';
import 'package:qonstanta/ui/shared/dialogs/basic_dialog.dart';
import 'package:stacked_services/stacked_services.dart';

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final builders = {
    DialogType.basic: (BuildContext context, DialogRequest request,
            Function(DialogResponse) completer) =>
        BasicDialog(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
