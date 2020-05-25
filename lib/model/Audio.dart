
class Audio {
    final int id;
    final String imageUrl;


    final String path;

    final String name;

    Audio({this.id,this.imageUrl='',this.path='',this.name=''});

    factory Audio.fromJson(Map<String, dynamic> json) {
        return Audio(
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