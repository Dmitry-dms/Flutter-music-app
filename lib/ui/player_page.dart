import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:musicapp/bloc/player/bloc_pl.dart';
import 'package:musicapp/bloc/player/player_bloc.dart';
import 'package:musicapp/ui/gradient_background.dart';

class Player extends StatefulWidget {
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  bool _animate = false;
  bool _play = false;

  void togglePlayStatus() {
    setState(() {
      _play = !_play;
    });
  }

  void toggleAnimation() {
    setState(() {
      _animate = !_animate;
    });
  }

  @override
  void initState() {
    // toggleAnimation();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final pictureWidth = width / 1.4;
    final primaryColor = Theme.of(context).primaryColor;
    final secondaryColor = Theme.of(context).accentColor;
    return Scaffold(
      backgroundColor: primaryColor,
      body: StreamBuilder<bool>(
          stream: context.bloc<PlayerBloc>().audioPLayer.isPlaying,
          builder: (context, isPlayingSnapshot) {
            return Stack(
              children: <Widget>[
                //  AnimatedBackground(),
                Positioned(
                    child: AppBar(
                  title: Align(
                    child: Text(
                      'Player',
                      style: TextStyle(color: secondaryColor),
                    ),
                    alignment: Alignment.center,
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                )),
                WaveWidget(
                    leftMargin: width / 2 - pictureWidth / 2 + 15,
                    topMargin: height / 2 - pictureWidth * 1.65,
                    rotate: 0,
                    widthWave: 210,
                    color: secondaryColor.withAlpha(60),
                    waveHeight: 20,
                    waveSpeed: 1,
                    isPlaying:
                        _animate && isPlayingSnapshot.data ? true : false),
                WaveWidget(
                    leftMargin: width / 2 + pictureWidth / 2 - 20,
                    topMargin: height / 2 - pictureWidth / 1.25,
                    rotate: 1,
                    widthWave: 210,
                    color: secondaryColor.withAlpha(60),
                    waveHeight: 20,
                    waveSpeed: 1,
                    isPlaying:
                        _animate && isPlayingSnapshot.data ? true : false),
                WaveWidget(
                    leftMargin: width / 2 - pictureWidth * 1.3,
                    topMargin: height / 2 - pictureWidth / 1.25,
                    rotate: 3,
                    widthWave: 210,
                    color: secondaryColor.withAlpha(60),
                    waveHeight: 20,
                    waveSpeed: 1,
                    isPlaying:
                        _animate && isPlayingSnapshot.data ? true : false),
                WaveWidget(
                    leftMargin: width / 2 - pictureWidth / 2 + 15,
                    topMargin: height / 2,
                    rotate: 2,
                    widthWave: 210,
                    color: secondaryColor.withAlpha(60),
                    waveHeight: 20,
                    waveSpeed: 1,
                    isPlaying:
                        _animate && isPlayingSnapshot.data ? true : false),
                Container(
                  child: BlocBuilder<PlayerBloc, PlayerState>(
                    bloc: context.bloc<PlayerBloc>(),
                    builder: (context, state) {
                      return Column(
                        children: <Widget>[
                          SizedBox(
                            height: 50,
                          ),
                          StreamBuilder(
                            stream: context
                                .bloc<PlayerBloc>()
                                .audioPLayer
                                .currentPosition,
                            builder: (context, currentPositionSnapshot) {
                              Duration duration = currentPositionSnapshot.data;
                              return StreamBuilder(
                                  stream: context
                                      .bloc<PlayerBloc>()
                                      .audioPLayer
                                      .current,
                                  builder: (context, currentSongSnapshot) {
                                    Playing currentAudio =
                                        currentSongSnapshot.data;
                                    if (currentAudio != null) {
                                      return Column(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(top: 30),
                                            width: pictureWidth,
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.circular(40.0),
                                                child: Image.network(currentAudio.audio.audio.metas.image.path, fit: BoxFit.fill,) ?? Image.asset('assets/waves.jpg')),
                                          ),
                                          SizedBox(height: 10,),
                                          Text(
                                              currentAudio
                                                  .audio.audio.metas.title,
                                              style: TextStyle(fontWeight: FontWeight.bold,
                                                  color: secondaryColor)),
                                          Slider(
                                            value: duration.inSeconds
                                                .ceilToDouble(),
                                            min: 0,
                                            max: currentAudio
                                                .audio.duration.inSeconds
                                                .ceilToDouble(),
                                            onChanged: (double newValue) {
                                              context.bloc<PlayerBloc>().add(
                                                  SeekToPlayerEvent(newValue));
                                            },
                                            activeColor: Colors.pink,
                                            inactiveColor: Colors.blueAccent,
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Column(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(top: 30),
                                            width: pictureWidth,
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.circular(40.0),
                                                child: Image.asset('assets/waves.jpg')),
                                          ),
                                          SizedBox(height: 10,),
                                          Text('music isn\'t playing',
                                              style: TextStyle(fontWeight: FontWeight.bold,
                                                  color: secondaryColor)),
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
                              Expanded(
                                  child: GestureDetector(
                                onTap: () {
                                  context
                                      .bloc<PlayerBloc>()
                                      .add(LoopSongPlayerEvent());
                                },
                                child: SvgPicture.asset(
                                  'assets/loop_button.svg',
                                  height: 25,
                                  width: 15,
                                  color: secondaryColor,
                                  fit: BoxFit.contain,
                                ),
                              )),
                              Expanded(
                                  child: GestureDetector(
                                onTap: () {
                                  context
                                      .bloc<PlayerBloc>()
                                      .add(PreviousSongPlayerEvent());
                                },
                                child: SvgPicture.asset(
                                  'assets/previous_button.svg',
                                  height: 25,
                                  width: 15,
                                  color: secondaryColor,
                                  fit: BoxFit.contain,
                                ),
                              )),
                              Expanded(
                                child: GestureDetector(
                                  child: isPlayingSnapshot.data == true
                                      ? SvgPicture.asset(
                                          'assets/pause_button.svg',
                                          height: 150,
                                          width: 100,
                                          color: secondaryColor,
                                          fit: BoxFit.fitWidth,
                                        )
                                      : SvgPicture.asset(
                                          'assets/play_button.svg',
                                          height: 150,
                                          width: 250,
                                          color: secondaryColor,
                                          fit: BoxFit.cover,
                                        ),
                                  onTap: () {
                                    togglePlayStatus();
                                    context
                                        .bloc<PlayerBloc>()
                                        .add(PlayOrPauseSongPlayerEvent());
                                  },
                                ),
                              ),
                              Expanded(
                                  child: GestureDetector(
                                onTap: () {
                                  context
                                      .bloc<PlayerBloc>()
                                      .add(NextSongPlayerEvent());
                                },
                                child: SvgPicture.asset(
                                  'assets/forward_button.svg',
                                  height: 25,
                                  width: 15,
                                  color: secondaryColor,
                                  fit: BoxFit.contain,
                                ),
                              )),
                              Expanded(
                                  child: GestureDetector(
                                onTap: () {
//                                    context
//                                        .bloc<PlayerBloc>()
//                                        .add(ShuffleSongPlayerEvent());
                                },
                                child: SvgPicture.asset(
                                  'assets/shuffle_button.svg',
                                  height: 25,
                                  width: 15,
                                  color: secondaryColor,
                                  fit: BoxFit.contain,
                                ),
                              )),
                            ],
                          ),
                          Switch(
                              inactiveThumbColor: secondaryColor,
                              activeColor: Colors.pink,
                              activeTrackColor: secondaryColor.withAlpha(40),
                              inactiveTrackColor: secondaryColor.withAlpha(40),
                              value: _animate,
                              onChanged: (value) {
                                if (value == true) {
                                  toggleAnimation();
                                } else {
                                  toggleAnimation();
                                }
                              })
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          }),
    );
  }
}
