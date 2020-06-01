import 'dart:convert';

import 'package:http/http.dart';
import 'package:musicapp/model/response.dart';

class ItunesApiProvider {
  Client client = Client();

  Future<String> getAudioFromApi(String songName) async {
    print('api_work');
    var response = await client.get(
        'https://itunes.apple.com/search?term=$songName&media=music&entity=album&limit=1');
    if (response.statusCode == 200) {
      var audioList = ItunesResponse.fromJson(json.decode(response.body));
      return (audioList.results.isEmpty) ? 'no image': audioList.results[0].imageUrl;
    } else {
      throw Exception('Album was not found');
    }
  }
}
