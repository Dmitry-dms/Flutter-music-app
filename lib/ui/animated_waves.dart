
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class AnimatedWave extends StatelessWidget {
  final double height;
  final double speed;
  Color color;
  bool isPlaying;


  AnimatedWave({this.height, this.speed,this.isPlaying,this.color});


  @override
  Widget build(BuildContext context) {
    return isPlaying ? LayoutBuilder(
      builder: (context,constraints){
        return Container(
          height: height,
          width: constraints.biggest.width,
          child: LoopAnimation(builder: (context,child, value){
              return CustomPaint(
                foregroundPainter: CurvePainter(value,color),
              );
          }, tween: 0.0.tweenTo(2*pi)),
        );
      },
    ) : Container();
  }
}
class CurvePainter extends CustomPainter {
  final double value;
  Color color;

  CurvePainter(this.value,this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final white = Paint()..color = color;//Colors.white.withAlpha(60)
    final path = Path();

    final y1 = sin(value);
    final y2 = sin(value + pi / 2);
    final y3 = sin(value + pi);


    final startPointY = size.height * (1 + 0.4 * y1);
    final controlPointY = size.height * (1 + 0.4 * y2);
    final endPointY = size.height * (1 + 0.4 * y3);

    path.moveTo(size.width * 0, startPointY);
    path.quadraticBezierTo(
        size.width * 0.5, controlPointY, size.width, endPointY);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();


    canvas.drawPath(path, white);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}