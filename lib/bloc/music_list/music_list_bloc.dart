import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:musicapp/model/audio.dart';
import 'package:musicapp/repository/repository.dart';

part 'music_list_event.dart';
part 'music_list_state.dart';


class MusicListBloc extends Bloc<MusicListEvent, MusicListState> {
  final repository = Repository.repository;
  bool _isFirstLaunch = true;
  @override
  MusicListState get initialState => InitialState();


  @override
  Future<Function> close() {
    print('closed');
  }


  @override
  Stream<MusicListState> mapEventToState(MusicListEvent event) async* {
    if (event is Fetch) {
      yield LoadingState();
      var directory = Directory(event.dirPath);
      await directory.list().forEach((index) async {
        var name = index.path.substring(26).split(RegExp('.mp3'))[0];
        if (name.startsWith(RegExp('^[0-9]'))){
          name = name.replaceAll(RegExp('^[0-9 -._]{1,5}'), '');
        }
        var audioFromApi = await repository.getAudioFromApi(name);
        var audio = MyAudio(
            id: (audioFromApi.id) == null ? name.hashCode : audioFromApi.id,
            imageUrl: audioFromApi.imageUrl,
            path: index.path,
            name: name);
        await repository.newAudio(audio);
      });
      yield Loaded(musicList: await repository.getAllAudio());
    }
    if (event is FetchFromDB){
      print('fetch from db');
      if (_isFirstLaunch) {
        _isFirstLaunch = false;
        yield LoadingState();

        List<MyAudio> songs = await repository.getAllAudio();
        yield Loaded(musicList: songs);
      }
    }
    if (event is InitialState){
      yield LoadingState();
      yield Loaded(musicList: await repository.getAllAudio());
    }
  }

}
