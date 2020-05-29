part of 'music_list_bloc.dart';

@immutable
abstract class MusicListState {}
class InitialState extends MusicListState{}
class LoadingState extends MusicListState {}

class Loaded extends MusicListState {
  final List<MyAudio> musicList;
  Loaded({@required this.musicList});
}

class Failure extends MusicListState {}