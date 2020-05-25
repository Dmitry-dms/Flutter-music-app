import 'dart:convert';

import 'package:http/http.dart';
import 'package:musicapp/model/audio.dart';
import 'package:musicapp/model/response.dart';

class ItunesApiProvider {
  Client client = Client();

  Future<Audio> getAudioFromApi(String songName) async {
    var response = await client.get(
        'https://itunes.apple.com/search?term=$songName&media=music&entity=album&limit=1');
    if (response.statusCode == 200) {
      var audioList = ItunesResponse.fromJson(json.decode(response.body));
      return (audioList.results.isEmpty) ? Audio(name: songName): audioList.results[0];
    } else {
      throw Exception('Album was not found');
    }
  }
}
