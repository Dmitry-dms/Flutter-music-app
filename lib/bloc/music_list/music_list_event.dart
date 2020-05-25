part of 'music_list_bloc.dart';

@immutable
abstract class MusicListEvent {}


class Fetch extends MusicListEvent {
  final String dirPath;
  Fetch({this.dirPath});
}

class FetchFromDB extends MusicListEvent{}