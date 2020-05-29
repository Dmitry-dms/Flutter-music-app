import 'package:equatable/equatable.dart';

abstract class PlayerEvent extends Equatable {
  const PlayerEvent();
}
class TestEvent extends PlayerEvent{
  @override
  List<Object> get props => null;
}
class FetchFromDbPlayerEvent extends PlayerEvent{
  @override
  List<Object> get props => null;
}

class SendIndexPlayerEvent extends PlayerEvent{
  final int audioIndex;

  SendIndexPlayerEvent(this.audioIndex);

  @override
  List<Object> get props => [audioIndex];
}
class PlayOrPauseSongPlayerEvent extends PlayerEvent{
  @override
  List<Object> get props => null;
}
class PauseSongPlayerEvent extends PlayerEvent{
  @override
  List<Object> get props => null;
}
class ForwardSongPlayerEvent extends PlayerEvent{
  @override
  List<Object> get props => null;
}
class PreviousSongPlayerEvent extends PlayerEvent{
  @override
  List<Object> get props => null;
}