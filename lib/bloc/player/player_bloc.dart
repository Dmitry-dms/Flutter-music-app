import 'dart:async';
import 'dart:wasm';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:musicapp/model/audio.dart';
import 'package:musicapp/repository/repository.dart';
import 'bloc_pl.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {

  final repository = Repository.repository;
  int _currentSongIndex;
  List<Audio> _playlist;
  List<Audio> _shuffledPlaylist;
  final audioPLayer = AssetsAudioPlayer();
  bool _isFirstLaunch = true;
  bool _shuffle = false;
  bool _loop = false;
  PlayerBloc() {
    add(FetchFromDbPlayerEvent());
  }

  @override
  PlayerState get initialState => InitialPlayerState();

  @override
  Stream<PlayerState> mapEventToState(
    PlayerEvent event,
  ) async* {
    if (event is FetchFromDbPlayerEvent) {
      List<MyAudio> list = await repository.getMoorAudios();
      _playlist = list.map((index) => mapToAudio(index)).toList();

    }
    if (event is SendIndexPlayerEvent) {

      if (_isFirstLaunch) {
        _currentSongIndex = event.props[0];
        audioPLayer.open(Playlist(audios: _playlist),
            autoStart: false, showNotification: true);
        _isFirstLaunch = false;
        audioPLayer.playlistPlayAtIndex(_currentSongIndex);
      }
      if (_currentSongIndex != event.props[0]) {
        _currentSongIndex = event.props[0];
        audioPLayer.playlistPlayAtIndex(_currentSongIndex);
      }
    }
    if (event is PlayOrPauseSongPlayerEvent) {
      if (_isFirstLaunch) {
        audioPLayer.open(Playlist(audios: _playlist),
            autoStart: true, showNotification: true);
        _isFirstLaunch = false;
      } else {
        audioPLayer.playOrPause();
      }
    }
    if (event is NextSongPlayerEvent){
      ++_currentSongIndex;
      audioPLayer.next();
    }
    if (event is PreviousSongPlayerEvent){
      --_currentSongIndex;
      audioPLayer.previous();
    }
    if (event is SeekToPlayerEvent){
      int sec = (event.props[0] as double).round();
      audioPLayer.seek(Duration(seconds: sec));
    }
    if (event is LoopSongPlayerEvent){
      audioPLayer.toggleLoop();
    }
//    if (event is ShuffleSongPlayerEvent) {
//      _shuffle=!_shuffle;
//      if (_shuffle) {
//        _shuffledPlaylist = _playlist;
//        _shuffledPlaylist.shuffle();
//        audioPLayer.open(Playlist(audios: _shuffledPlaylist),showNotification: true, autoStart: false);
//
//      }
//    }

  }

}
