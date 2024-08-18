import 'package:qonstanta/app/app.locator.dart';
import 'package:qonstanta/helpers/result.dart';
import 'package:qonstanta/models/profile.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_migration_service/sqflite_migration_service.dart';
import 'package:get/get.dart';

const String DB_NAME = 'qonstanta_database.sqlite';
const String tableProfile = 'profile';

@lazySingleton
class DatabaseService {
  final _migrationService = locator<DatabaseMigrationService>();
  Database? _db;

  Future initialise() async {
    _db = await openDatabase(DB_NAME, version: 1);

    await _migrationService.runMigration(
      _db,
      migrationFiles: [
        '1_create_schema.sql',
      ],
      verbose: true,
    );
  }

  Future<Profile> getProfile() async {
    List<Map> result = await _db!.query(tableProfile);
    return result.map((e) => Profile.fromJson(e)).toList()[0];
  }

  Future updateProfile({Profile? profile}) async {
    try {
      int result = await _db!.update(
        tableProfile,
        profile!.toJsonLocal(),
        where: 'id = ?',
        whereArgs: [profile.id],
      );
      return Result.success(data: result, message: 'update_success'.tr);
    } catch (e) {
      print('Could not update the data: $e');
      return Result.error(message: 'update_failed'.trArgs([e.toString()]));
    }
  }
}
