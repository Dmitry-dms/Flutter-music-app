import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/bloc/music_list/music_list_bloc.dart';
import 'package:musicapp/bloc/player/bloc.dart';
import 'package:musicapp/bloc/player/player_bloc.dart';
import 'music_list_page.dart';

class Player extends StatefulWidget {
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {

  bool _play = false;
  double _currentMusicTime = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Player'),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: BlocBuilder<PlayerBloc, PlayerState>(
          bloc: context.bloc<PlayerBloc>(),
          builder: (context, state) {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    StreamBuilder(
                      stream: context.bloc<PlayerBloc>().audioPLayer.currentPosition,
                      builder: (context, snapshot){
                        Duration duration = snapshot.data;
                          return StreamBuilder(
                            stream: context.bloc<PlayerBloc>().audioPLayer.current,
                            builder: (context, snapshot) {
                              Playing songDuration = snapshot.data;
                              if (songDuration != null) {
                                return Slider(
                                    value: duration.inSeconds.ceilToDouble(),
                                    min: 0,
                                    max: songDuration.audio.duration.inSeconds.ceilToDouble(),
                                    onChanged: null
                                );
                              } else {
                                return Text('music isn\'t playing');
                              }
                            }
                          );
                      },
                    ),
                    RaisedButton(
                      onPressed: () {
                        context.bloc<PlayerBloc>().add(PlayOrPauseSongPlayerEvent());
                      },
                      child: Text(_play ? 'stop' : 'play'),
                    ),
                  ],
                ),
              );
          },
        ),
      ),
    );
  }
}
