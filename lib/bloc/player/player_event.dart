import 'package:equatable/equatable.dart';


abstract class PlayerEvent extends Equatable {
  const PlayerEvent();
}

class FetchFromDbPlayerEvent extends PlayerEvent{
  @override
  List<Object> get props => null;
}

class SendIndexPlayerEvent extends PlayerEvent{
  final int _audioIndex;

  SendIndexPlayerEvent(this._audioIndex);

  @override
  List<Object> get props => [_audioIndex];
}
class PlayOrPauseSongPlayerEvent extends PlayerEvent{
  @override
  List<Object> get props => null;
}

class NextSongPlayerEvent extends PlayerEvent{
  @override
  List<Object> get props => null;
}
class PreviousSongPlayerEvent extends PlayerEvent{
  @override
  List<Object> get props => null;
}
class LoopSongPlayerEvent extends PlayerEvent{
  @override
  List<Object> get props => null;
}
class ShuffleSongPlayerEvent extends PlayerEvent{
  @override
  List<Object> get props => null;
}
class SeekToPlayerEvent extends PlayerEvent{
  final double _time;

  SeekToPlayerEvent(this._time);

  @override
  List<Object> get props => [_time];
}
