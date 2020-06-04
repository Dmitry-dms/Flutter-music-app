import 'package:flutter/material.dart';
import 'package:musicapp/ui/animated_waves.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class AnimatedBackground extends StatelessWidget {
  final tween = MultiTween<String>()
    ..add('color1', Color(0xffD38312).tweenTo(Colors.lightBlue.shade900),
        3.seconds)..add(
        'color2', Color(0xffA83279).tweenTo(Colors.blue.shade600), 3.seconds);

  @override
  Widget build(BuildContext context) {
    return MirrorAnimation<MultiTweenValues<String>>(
        tween: tween,
        duration: tween.duration,
        builder: (context, child, value) {
          return Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [value.get('color1'), value.get('color2')])),
          );
        });
  }
}

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  bool _isPlaying = false;
  void toggle(){
    setState(() {
      _isPlaying=!_isPlaying;
    });
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final width = MediaQuery
        .of(context)
        .size
        .width;
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Positioned.fill(child: AnimatedBackground()),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: toggle,
              child: Container(
                height: 200,
                width: 200,
                color: Colors.white,
              ),
            ),
          ),
          WaveWidget(
              leftMargin: width / 2 -100,
              topMargin: height / 2 -290,
              rotate: 0,
              widthWave: 200,
              color: Colors.white.withAlpha(60),
              waveHeight: 20,
              waveSpeed: 1,
              isPlaying: _isPlaying
          ),
          WaveWidget(
              leftMargin: width / 2 +100,
              topMargin: height / 2 -112,
              rotate: 1,
              widthWave: 100,
              color: Colors.white.withAlpha(60),
              waveHeight: 50,
              waveSpeed: 1,
              isPlaying: _isPlaying
          ),
          WaveWidget(
              leftMargin: width / 2 - 100,
              topMargin: height / 2 +80,
              rotate: 2,
              widthWave: 200,
              color: Colors.white.withAlpha(60),
              waveHeight: 10,
              waveSpeed: 1,
              isPlaying: _isPlaying
          ),
          WaveWidget(
              color: Colors.white.withAlpha(60),
              isPlaying: _isPlaying,
              leftMargin: width / 2 - 200,
              topMargin: height / 2 - 112,
              rotate: 3,
              waveHeight: 50,
              waveSpeed: 1,
              widthWave: 100
          ),
        ],
      ),
    );
  }
}

class WaveWidget extends StatelessWidget {
  WaveWidget({
    Key key,
    @required this.leftMargin,
    @required this.topMargin,
    @required this.rotate,
    @required this.widthWave,
    @required this.color,
    @required this.waveHeight,
    @required this.waveSpeed,
    @required this.isPlaying,
  }) : super(key: key);

  final double leftMargin;
  final double topMargin;
  final double widthWave;
  final int rotate;
  Color color;
  final double waveHeight;
  final double waveSpeed;
  bool isPlaying;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        height: 200,
        width: widthWave,
        left: leftMargin,
        top: topMargin,
        child: RotatedBox(
          quarterTurns: rotate,
          child: AnimatedWave(
            height: waveHeight,
            speed: waveSpeed,
            isPlaying: isPlaying,
            color: color,
          ),
        ));
  }
}
