import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:musicapp/bloc/music_list/music_list_bloc.dart';
import 'package:musicapp/model/audio.dart';
import 'package:musicapp/repository/database/moor/moor_database.dart';
import 'package:musicapp/repository/repository.dart';
import './bloc.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {

  final repository = Repository.repository;
  int _currentSongIndex;
  List<Audio> _playlist;
  final audioPLayer = AssetsAudioPlayer();
  bool _isFirstLaunch = true;
  PlayerBloc() {
    add(FetchFromDbPlayerEvent());
  }
  Duration get songDuration => (audioPLayer.current.value.audio.duration != null) ?  audioPLayer.current.value.audio.duration :Duration();


  @override
  PlayerState get initialState => InitialPlayerState();

  @override
  Stream<PlayerState> mapEventToState(
    PlayerEvent event,
  ) async* {
    if (event is FetchFromDbPlayerEvent) {
    //  List<MyAudio> list = await repository.getAllAudio();
     // _playlist = list.map((index) => mapToAudio(index)).toList();
      repository.insertAudio(MyAudio2(
        id: 1,
        name: 'Namedf',
        path: 'fdkkk/path',
        url: 'www.picture.com'
      ));
      print('added');
    }
    if (event is SendIndexPlayerEvent) {
      _currentSongIndex = event.audioIndex;
      if (audioPLayer.isPlaying.value){
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
      audioPLayer.next();
    }
    if (event is PreviousSongPlayerEvent){
      audioPLayer.previous();
    }
  }
}
