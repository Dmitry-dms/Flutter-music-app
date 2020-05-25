
import 'package:flutter/material.dart';
import 'package:musicapp/ui/music_list_page.dart';
import 'package:musicapp/ui/player_page.dart';



void main() => runApp(HomePage());

final controller = PageController(initialPage: 0);
final pageView = PageView(
  controller: controller,
  children: <Widget>[MusicList(),Player()],
);

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: pageView,
    );
  }
}

