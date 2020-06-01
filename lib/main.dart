import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/bloc/music_list/music_list_bloc.dart';
import 'package:musicapp/bloc/player/bloc_pl.dart';
import 'package:musicapp/ui/gradient_background.dart';
import 'package:musicapp/ui/music_list_page.dart';
import 'package:musicapp/ui/player_page.dart';

void main() => runApp(HomePage());
//void main() => runApp(AnimatedBackground());

final controller = PageController(initialPage: 0);
final _pageView = PageView(
  controller: controller,
  children: <Widget>[MusicList(), Player()],
);

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: BlocProvider(create: (_) => _bloc, child: _pageView),
      home: MultiBlocProvider(providers: [
        BlocProvider<MusicListBloc>(
          create: (context) => MusicListBloc(),
        ),
        BlocProvider<PlayerBloc>(
          create: (context) => PlayerBloc(),
        )
      ], child: _pageView),
    );
  }
}
