import 'dart:io';

import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:musicapp/model/audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
part 'moor_database.g.dart';


LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'Audiosdb.sqlite'));
    return VmDatabase(file);
  });
}

@DataClassName('MyAudio')
class Audios extends Table {
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get imageUrl => text().withLength(min: 0,max: 150)();
  TextColumn get path => text().withLength(min: 1, max: 100)();

  @override
  Set<Column> get primaryKey => {name};
}

@UseMoor(tables: [Audios],daos: [AudiosDao])
class MoorDatabase extends _$MoorDatabase {
  MoorDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;


}

@UseDao(tables: [Audios])
class AudiosDao extends DatabaseAccessor<MoorDatabase> with _$AudiosDaoMixin {
  final MoorDatabase db;
  AudiosDao(this.db) : super(db);

  Future<List<MyAudio>> get allAudios => select(audios).get();
  Stream<List<MyAudio>> watchAudios() => select(audios).watch();
  Future insertAudio(Insertable<MyAudio> audio) => //into(audios).insert(audio);
      into(audios).insert(audio,mode: InsertMode.insertOrIgnore);

  Future<MyAudio> audioByName(String songName) => (select(audios)..where((n)=>n.name.equals(songName))).getSingle();

}