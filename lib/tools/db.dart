import 'dart:io';
// import 'package:nytiona/tools/db_migration.dart';
import 'package:ny_tiona/tools/fast_cache.dart';
import 'package:ny_tiona/tools/manage_file.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// https://github.com/tekartik/sqflite/blob/master/sqflite/doc/opening_asset_db.md
// https://medium.com/flutter-community/flutter-design-patterns-1-singleton-437f04e923ce

class DB {
  static Database? _db;
  // Update it if we have been updated the database
  static int version = 1;

  static Future<Database> getInstance() async {
    if (DB._db == null) {
      try {
        String databaseFromSystem =
            join(await getDatabasesPath(), "tiona_app.db");
        String databaseFromAsset = join("assets", "database/tiona.db");

        bool exists = await databaseExists(databaseFromSystem);
        if (!exists) {
          // No database exist
          try {
            await Directory(dirname(databaseFromSystem))
                .create(recursive: true);
          } catch (_) {
            rethrow;
          }

          await copyFileInRootBundleToSystemFile(
            databaseFromAsset,
            databaseFromSystem,
          );

          Database database = await openDatabase(databaseFromSystem);
          database.setVersion(DB.version);
          DB._db = database;
          return Future<Database>.value(DB._db);
        } else {
          // Database exist
          Database database = await openDatabase(databaseFromSystem);
          // Handle migration in v2
          // int oldVerion = await database.getVersion();
          // if (oldVerion < DB.version) {
          //   // An update for the database was occured
          //   await handleMigration(
          //     database: database,
          //     dbSourcePath: databaseFromAsset,
          //     dbTargetPath: databaseFromSystem,
          //     newVersion: DB.version,
          //   );
          // }
          DB._db = database;
          return Future<Database>.value(DB._db);
        }
      } catch (e) {
        rethrow;
      }
    } else {
      return Future<Database>.value(DB._db);
    }
  }

  static Future<List<Map<String, Object?>>> query(String sql) async {
    try {
      if (FastCache.has(sql)) {
        return await FastCache.get(sql);
      }
      var db = await DB.getInstance();
      return await db.rawQuery(sql);
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<int> update(String sql) async {
    try {
      var db = await DB.getInstance();
      FastCache.clear();
      return await db.rawUpdate(sql);
    } catch (e) {
      throw Exception(e);
    }
  }
}
