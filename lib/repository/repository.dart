import 'package:musicapp/model/audio.dart';
import 'package:musicapp/repository/api/itunes_api_provider.dart';
import 'package:musicapp/repository/database/Database.dart';

class Repository {
  Repository._();
  static final Repository repository = Repository._();
  final _apiProvider = ItunesApiProvider();
  final _db = DBProvider.db;


  newAudio(Audio newAudio) async {
    return await _db.newAudio(newAudio);
  }

  Future<List<Audio>> getAllAudio() async {
    return await _db.getAllAudio();
  }

  Future<Audio> getAudioFromApi(String songName) =>
      _apiProvider.getAudioFromApi(songName);
}
