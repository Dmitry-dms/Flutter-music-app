import 'package:musicapp/model/audio.dart';
import 'package:musicapp/repository/api/itunes_api_provider.dart';

import 'package:musicapp/repository/database/moor/moor_database.dart';

class Repository {
  Repository._();
  static final Repository repository = Repository._();
  final _db = MoorDatabase().audiosDao;


  final _apiProvider = ItunesApiProvider();

  Future<String> getAudioFromApi(String songName) {

   return _apiProvider.getAudioFromApi(songName);
  }
  insertAudio(MyAudio newAudio) async {
    return await _db.insertAudio(newAudio);
  }
  Future<MyAudio> getAudioFromDbByName(String songName) async{
    return await _db.audioByName(songName);
  }

  Future<List<MyAudio>> getMoorAudios() async => await _db.allAudios;
}
