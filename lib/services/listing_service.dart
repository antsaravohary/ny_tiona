import 'package:ny_tiona/models/music.dart';
import 'package:ny_tiona/tools/db.dart';

class ListingService {
  static Future<List<Music>> get() async {
    try {
      var musicMap = await DB.query("""SELECT 
          musics.id as id, 
          musics.title as title, 
          musics.audio as audio,
          musics.pdf as pdf,
          musics.favoris as favoris,
          musics.numero as numero,
          musics.created_at as created_at,
          musics.updated_at as updated_at,
          musics.type_id as type_id,
          musics.lyrics as lyrics,
          types.name as label 
          FROM musics 
          LEFT JOIN types ON musics.type_id = types.id 
          ORDER BY numero ASC""");
      return Future.value(
        List.generate(
          musicMap.length,
          (index) => Music.fromMap(musicMap[index]),
        ),
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<Music> getById(int id) async {
    try {
      var musicMap = await DB.query('SELECT * FROM musics WHERE id=$id');
      return Future.value(Music.fromMap(musicMap[0]));
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<Music> toggleFavorite(int id, int value) async {
    try {
      await DB.update('Update musics set favoris=$value WHERE id=$id');
      return await ListingService.getById(id);
    } catch (e) {
      throw Exception(e);
    }
  }
}
