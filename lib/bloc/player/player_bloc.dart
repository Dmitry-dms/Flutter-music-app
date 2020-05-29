import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:musicapp/bloc/music_list/music_list_bloc.dart';
import 'package:musicapp/model/audio.dart';
import 'package:musicapp/repository/repository.dart';
import './bloc.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {

  final repository = Repository.repository;
  int _currentSongIndex;
  List<Audio> _playlist;
  final _audioPLayer = AssetsAudioPlayer();
  bool _isFirstLaunch = true;
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
      List<MyAudio> list = await repository.getAllAudio();
      print(list);
      _playlist = list.map((index) => mapToAudio(index)).toList();
    }
    if (event is SendIndexPlayerEvent) {
      _currentSongIndex = event.audioIndex;
      print(_playlist[_currentSongIndex].metas.title);
    }
    if (event is PlayOrPauseSongPlayerEvent) {
      if (_isFirstLaunch) {
        _audioPLayer.open(Playlist(audios: _playlist),
            autoStart: true, showNotification: true);
        _isFirstLaunch = false;
      } else {
        _audioPLayer.playOrPause();
      }
    }
  }
}
