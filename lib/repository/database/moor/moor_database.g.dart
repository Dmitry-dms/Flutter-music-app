// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class AudiosCompanion extends UpdateCompanion<MyAudio> {
  final Value<String> name;
  final Value<String> imageUrl;
  final Value<String> path;
  const AudiosCompanion({
    this.name = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.path = const Value.absent(),
  });
  AudiosCompanion.insert({
    @required String name,
    @required String imageUrl,
    @required String path,
  })  : name = Value(name),
        imageUrl = Value(imageUrl),
        path = Value(path);
  static Insertable<MyAudio> custom({
    Expression<String> name,
    Expression<String> imageUrl,
    Expression<String> path,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (imageUrl != null) 'artworkUrl100': imageUrl,
      if (path != null) 'path': path,
    });
  }

  AudiosCompanion copyWith(
      {Value<String> name, Value<String> imageUrl, Value<String> path}) {
    return AudiosCompanion(
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      path: path ?? this.path,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (imageUrl.present) {
      map['artworkUrl100'] = Variable<String>(imageUrl.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    return map;
  }
}

class $AudiosTable extends Audios with TableInfo<$AudiosTable, MyAudio> {
  final GeneratedDatabase _db;
  final String _alias;
  $AudiosTable(this._db, [this._alias]);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  final VerificationMeta _imageUrlMeta = const VerificationMeta('artworkUrl100');
  GeneratedTextColumn _imageUrl;
  @override
  GeneratedTextColumn get imageUrl => _imageUrl ??= _constructImageUrl();
  GeneratedTextColumn _constructImageUrl() {
    return GeneratedTextColumn(
      'artworkUrl100',
      $tableName,
      false,
    );
  }

  final VerificationMeta _pathMeta = const VerificationMeta('path');
  GeneratedTextColumn _path;
  @override
  GeneratedTextColumn get path => _path ??= _constructPath();
  GeneratedTextColumn _constructPath() {
    return GeneratedTextColumn('path', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  @override
  List<GeneratedColumn> get $columns => [name, imageUrl, path];
  @override
  $AudiosTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'audios';
  @override
  final String actualTableName = 'audios';
  @override
  VerificationContext validateIntegrity(Insertable<MyAudio> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('artworkUrl100')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['artworkUrl100'], _imageUrlMeta));
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path'], _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name};
  @override
  MyAudio map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return MyAudio.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $AudiosTable createAlias(String alias) {
    return $AudiosTable(_db, alias);
  }
}

abstract class _$MoorDatabase extends GeneratedDatabase {
  _$MoorDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $AudiosTable _audios;
  $AudiosTable get audios => _audios ??= $AudiosTable(this);
  AudiosDao _audiosDao;
  AudiosDao get audiosDao => _audiosDao ??= AudiosDao(this as MoorDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [audios];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$AudiosDaoMixin on DatabaseAccessor<MoorDatabase> {
  $AudiosTable get audios => attachedDatabase.audios;
}
