import 'package:flutter/material.dart';
import 'package:qonstanta/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';

void setupSnackbarConfig() {
  final snackbarService = locator<SnackbarService>();

  snackbarService.registerSnackbarConfig(SnackbarConfig(
    backgroundColor: Colors.grey.withOpacity(0.2),
    barBlur: 7.0,
  ));
}
