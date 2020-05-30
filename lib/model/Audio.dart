
import 'package:assets_audio_player/assets_audio_player.dart';

Audio mapToAudio(MyAudio audio) {
    return Audio.file(audio.path,
    metas: Metas(
        image: MetasImage.network(audio.imageUrl),
        title: audio.name
    ));
}

class MyAudio {
    final int id;
    final String imageUrl;


    final String path;

    final String name;

    MyAudio({this.id,this.imageUrl='',this.path='',this.name=''});

    factory MyAudio.fromJson(Map<String, dynamic> json) {
        return MyAudio(
            id: json['artistId'],
            name: json['name'],
            path: json['path'],
            imageUrl: json['artworkUrl100'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['name'] = this.name;
        data['path'] = this.path;
        data['artistId'] = this.id;
        data['artworkUrl100'] = this.imageUrl;
        return data;
    }
}