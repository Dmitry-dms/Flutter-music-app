import 'package:musicapp/model/audio.dart';
import 'package:musicapp/repository/api/itunes_api_provider.dart';
import 'package:musicapp/repository/database/database.dart';
import 'package:musicapp/repository/database/moor/moor_database.dart';

class Repository {
  Repository._();
  static final Repository repository = Repository._();
  final _apiProvider = ItunesApiProvider();
  final _db = DBProvider.db;


  newAudio(MyAudio newAudio) async {
    return await _db.newAudio(newAudio);
  }

  Future<List<MyAudio>> getAllAudio() async {
    return await _db.getAllAudio();
  }

  Future<MyAudio> getAudioFromApi(String songName) =>
      _apiProvider.getAudioFromApi(songName);

  ///////////////////////
  final _db2 = MoorDatabase().audiosDao;

  insertAudio(MyAudio2 newAudio) async {
    return await _db2.insertAudio(newAudio);
  }

  Future<List<MyAudio2>> getMoorAudios() async => await _db2.allAudios;
}
