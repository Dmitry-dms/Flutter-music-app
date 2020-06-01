import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class AnimatedBackground extends StatelessWidget {
  final tween = MultiTween<String>()
    ..add('color1', Color(0xffD38312).tweenTo(Colors.lightBlue.shade900),
        3.seconds)
    ..add('color2', Color(0xffA83279).tweenTo(Colors.blue.shade600), 3.seconds);

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
