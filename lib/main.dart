import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicapp/tst.dart';

void main() => runApp(HomePage());

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MusicList(),
    );
  }
}

class MusicList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music list'),
      ),
    );
  }
}
