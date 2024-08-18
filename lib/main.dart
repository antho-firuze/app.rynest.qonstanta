import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qonstanta/app/app.locator.dart';
import 'package:qonstanta/app/app.router.dart';
import 'package:qonstanta/helpers/translation.dart';
import 'package:qonstanta/services/fcm_service.dart';
import 'package:qonstanta/services/session_service.dart';
import 'package:qonstanta/ui/shared/setup_dialog_ui.dart';
import 'package:get/route_manager.dart';
import 'package:qonstanta/ui/shared/setup_snackbar_config.dart';
import 'package:qonstanta/ui/shared/ui_helper.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Set the background messaging handler early on, as a named top-level function
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  fcmListen();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: primaryColor),
  );
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  setupLocator();
  setupDialogUi();
  setupSnackbarConfig();
  // Specialize for SessionService
  locator.registerSingleton(await SessionService.getInstance());
  runApp(GetMaterialApp(
    home: MyApp(),
    translations: Translation(),
    locale: Locale('id', 'ID'),
    fallbackLocale: Locale('id', 'ID'),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qonstanta',
      debugShowCheckedModeBanner: false,
      // home: StartUpView(),
      // navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
    );
  }
}
