import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/bloc/music_list/music_list_bloc.dart';
import 'package:musicapp/bloc/player/bloc_pl.dart';
import 'package:musicapp/bloc/theme/theme_bloc.dart';
import 'package:musicapp/ui/gradient_background.dart';
import 'package:musicapp/ui/music_list_page.dart';
import 'package:musicapp/ui/player_page.dart';

void main() => runApp(HomePage());
//void main() => runApp(MaterialApp(home: Test(),debugShowCheckedModeBanner: false,));

final controller = PageController(initialPage: 0);
final _pageView = PageView(
  controller: controller,
  children: <Widget>[MusicList(),  Player()],
);

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        ),
      BlocProvider<MusicListBloc>(
        create: (context) => MusicListBloc(),
      ),
      BlocProvider<PlayerBloc>(
        create: (context) => PlayerBloc(),
      )
    ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context,state) {
          return MaterialApp(
            theme: state.themeData,
              debugShowCheckedModeBanner: false,
              home: _pageView,
          );
          }
        ),
      );
  }
}
