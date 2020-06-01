
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:moor/moor.dart';
import 'package:musicapp/repository/database/moor/moor_database.dart';


//new image https://i.pinimg.com/736x/59/ad/f3/59adf3347bfaf4b864c2e66f8406dea0--sound-waves.jpg
Audio mapToAudio(MyAudio audio) {
    return Audio.file(audio.path,
    metas: Metas(
        image: (audio.imageUrl != 'no image' ) ? MetasImage.network(audio.imageUrl)  : MetasImage.network('https://i.pinimg.com/736x/59/ad/f3/59adf3347bfaf4b864c2e66f8406dea0--sound-waves.jpg'),
        title: audio.name
    ));
}
class MyAudio extends DataClass implements Insertable<MyAudio> {
    final String name;
    final String imageUrl;
    final String path;
    MyAudio({@required this.name, @required this.imageUrl, @required this.path});
    factory MyAudio.fromData(Map<String, dynamic> data, GeneratedDatabase db,
        {String prefix}) {
        final effectivePrefix = prefix ?? '';
        final stringType = db.typeSystem.forDartType<String>();
        return MyAudio(
            name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
            imageUrl: stringType
                .mapFromDatabaseResponse(data['${effectivePrefix}artworkUrl100']),
            path: stringType.mapFromDatabaseResponse(data['${effectivePrefix}path']),
        );
    }
    @override
    Map<String, Expression> toColumns(bool nullToAbsent) {
        final map = <String, Expression>{};
        if (!nullToAbsent || name != null) {
            map['name'] = Variable<String>(name);
        }
        if (!nullToAbsent || imageUrl != null) {
            map['artworkUrl100'] = Variable<String>(imageUrl);
        }
        if (!nullToAbsent || path != null) {
            map['path'] = Variable<String>(path);
        }
        return map;
    }

    AudiosCompanion toCompanion(bool nullToAbsent) {
        return AudiosCompanion(
            name: name == null && nullToAbsent ? const Value.absent() : Value(name),
            imageUrl: imageUrl == null && nullToAbsent
                ? const Value.absent()
                : Value(imageUrl),
            path: path == null && nullToAbsent ? const Value.absent() : Value(path),
        );
    }

    factory MyAudio.fromJson(Map<String, dynamic> json,
        {ValueSerializer serializer}) {
        serializer ??= moorRuntimeOptions.defaultSerializer;
        return MyAudio(
            name: serializer.fromJson<String>(json['name']),
            imageUrl: serializer.fromJson<String>(json['artworkUrl100']),
            path: serializer.fromJson<String>(json['path']),
        );
    }
    @override
    Map<String, dynamic> toJson({ValueSerializer serializer}) {
        serializer ??= moorRuntimeOptions.defaultSerializer;
        return <String, dynamic>{
            'name': serializer.toJson<String>(name),
            'artworkUrl100': serializer.toJson<String>(imageUrl),
            'path': serializer.toJson<String>(path),
        };
    }

    MyAudio copyWith({String name, String imageUrl, String path}) => MyAudio(
        name: name ?? this.name,
        imageUrl: imageUrl ?? this.imageUrl,
        path: path ?? this.path,
    );
    @override
    String toString() {
        return (StringBuffer('MyAudio(')
            ..write('name: $name, ')
            ..write('imageUrl: $imageUrl, ')
            ..write('path: $path')
            ..write(')'))
            .toString();
    }

    @override
    int get hashCode =>
        $mrjf($mrjc(name.hashCode, $mrjc(imageUrl.hashCode, path.hashCode)));
    @override
    bool operator ==(dynamic other) =>
        identical(this, other) ||
            (other is MyAudio &&
                other.name == this.name &&
                other.imageUrl == this.imageUrl &&
                other.path == this.path);
}
