import 'package:ny_tiona/tools/manage_file.dart';
import 'package:sqflite/sqlite_api.dart';

Future<List<int>> getLastFavorisList(Database database) async {
  try {
    var favoris =
        await database.rawQuery('SELECT id FROM music WHERE favoris=1');
    return Future.value(List.generate(
      favoris.length,
      (index) => favoris[index]['id'] as int,
    ));
  } catch (e) {
    rethrow;
  }
}

Future<bool> bindFavorisList(Database database, List<int> favorisId) async {
  try {
    await database.rawUpdate(
      'UPDATE music SET favoris=1 WHERE id IN(${favorisId.join(',')})',
    );
    return Future.value(true);
  } catch (e) {
    rethrow;
  }
}

Future<bool> handleMigration({
  required Database database,
  required String dbSourcePath,
  required String dbTargetPath,
  required int newVersion,
}) async {
  try {
    // Get all favoris before update the database
    List<int> favorisId = await getLastFavorisList(database);

    // Update database
    await copyFileInRootBundleToSystemFile(
      dbSourcePath,
      dbTargetPath,
    );

    // Bind all previous favoris to the new database
    await bindFavorisList(database, favorisId);

    database.setVersion(newVersion);
    return Future.value(true);
  } catch (e) {
    rethrow;
  }
}
