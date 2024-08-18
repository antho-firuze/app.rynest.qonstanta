import 'package:qonstanta/api/api_service.dart';
import 'package:qonstanta/services/database_service.dart';
import 'package:qonstanta/services/fcm_service.dart';
import 'package:qonstanta/services/media_service.dart';
import 'package:qonstanta/ui/views/startup/startup_view.dart';
import 'package:sqflite_migration_service/sqflite_migration_service.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: StartUpView, initial: true),
  ],
  dependencies: [
    LazySingleton(classType: DatabaseService),
    LazySingleton(classType: DatabaseMigrationService),
    LazySingleton(classType: MediaService),
    LazySingleton(classType: ApiService),
    LazySingleton(classType: FcmService),

    // LazySingleton(classType: FirebaseAuthenticationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: SnackbarService),
  ],
)
class AppSetup {}
