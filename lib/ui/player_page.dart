import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/bloc/player/bloc_pl.dart';
import 'package:musicapp/bloc/player/player_bloc.dart';
import 'package:musicapp/ui/gradient_background.dart';

class Player extends StatefulWidget {
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  bool _play = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Center(
          child: Text(
            'Player',
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: <Widget>[
         AnimatedBackground(),
          Container(
        //    decoration: BoxDecoration(color: Colors.white),
            child: BlocBuilder<PlayerBloc, PlayerState>(
              bloc: context.bloc<PlayerBloc>(),
              builder: (context, state) {
                return Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      width: width / 1.2,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(40.0),
                          child: Image.asset('assets/waves.jpg')),
                    ),
                    StreamBuilder(
                      stream:
                      context.bloc<PlayerBloc>().audioPLayer.currentPosition,
                      builder: (context, snapshot) {
                        Duration duration = snapshot.data;
                        return StreamBuilder(
                            stream: context.bloc<PlayerBloc>().audioPLayer.current,
                            builder: (context, snapshot) {
                              Playing currentAudio = snapshot.data;
                              if (currentAudio != null) {
                                return Column(
                                  children: <Widget>[
                                    Text(currentAudio.audio.audio.metas.title),
                                    Slider(
                                      value: duration.inSeconds.ceilToDouble(),
                                      min: 0,
                                      max: currentAudio.audio.duration.inSeconds
                                          .ceilToDouble(),
                                      onChanged: (double newValue) {
                                        context
                                            .bloc<PlayerBloc>()
                                            .add(SeekToPlayerEvent(newValue));
                                      },
                                      activeColor: Colors.pink,
                                      inactiveColor: Colors.blueAccent,
                                    ),
                                  ],
                                );
                              } else {
                                return Column(
                                  children: <Widget>[
                                    Text('music isn\'t playing'),
                                    Slider(value: 0.0, onChanged: null)
                                  ],
                                );
                              }
                            });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[

                        Container(
                          width: 70,
                          child: FlatButton(
                              textColor: Colors.amber,
                              onPressed: () {},
                              child: Icon(Icons.shuffle)),
                        ),
                        Container(
                          width: 70,
                          child: RaisedButton(
                            onPressed: () {
                              context
                                  .bloc<PlayerBloc>()
                                  .add(PreviousSongPlayerEvent());
                            },
                            child: Text('prev'),
                          ),
                        ),
                        Container(
                          width: 70,
                          child: RaisedButton(
                            onPressed: () {
                              context
                                  .bloc<PlayerBloc>()
                                  .add(PlayOrPauseSongPlayerEvent());
                            },
                            child: Text(_play ? 'stop' : 'play'),
                          ),
                        ),
                        Container(
                          width: 70,
                          child: RaisedButton(
                            onPressed: () {
                              context.bloc<PlayerBloc>().add(NextSongPlayerEvent());
                            },
                            child: Text('next'),
                          ),
                        ),
                        Container(
                          width: 70,
                          child: FlatButton(
                              onPressed: null, child: Icon(Icons.shuffle)),
                        )
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
