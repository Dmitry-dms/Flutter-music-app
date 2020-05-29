import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:musicapp/model/audio.dart';

abstract class PlayerState extends Equatable {
  const PlayerState();
}

class InitialPlayerState extends PlayerState {
  @override
  List<Object> get props => [];
}
class LoadedListSongsPlayerState extends PlayerState{

  @override
  List<Object> get props => [];
}

class LoadedPlayerState extends PlayerState {
  final List<MyAudio> musicList;
  LoadedPlayerState({@required this.musicList});
  @override
  List<Object> get props => [musicList];
}