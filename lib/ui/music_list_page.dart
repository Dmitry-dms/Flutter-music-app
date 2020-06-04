import 'dart:io';

import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/bloc/music_list/music_list_bloc.dart';
import 'package:musicapp/bloc/player/bloc_pl.dart';
import 'package:musicapp/bloc/theme/theme_bloc.dart';
import 'package:musicapp/model/audio.dart';
import 'package:musicapp/main.dart';
import 'package:musicapp/ui/global/app_themes.dart';

class MusicList extends StatelessWidget {
  Future<String> _pickDir(BuildContext context) async {
    String path = await FilesystemPicker.open(
      title: 'Save to folder',
      context: context,
      rootDirectory: Directory('/storage/emulated/0/'),
      fsType: FilesystemType.folder,
      pickText: 'Save file to this folder',
    );
    return path;
  }

  bool _isFirstLaunch = true;

  bool _togleTheme = false;
  void toggleTheme(){
    _togleTheme=!_togleTheme;
  }

  @override
  Widget build(BuildContext context) {
    if (_isFirstLaunch) context.bloc<MusicListBloc>().add(FetchFromDB());
    _isFirstLaunch = false;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Music list'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add, color: Theme.of(context).accentColor,), onPressed: (){
            if (!_togleTheme) {
              context.bloc<ThemeBloc>().add(ThemeChanged(AppTheme.Black));
              toggleTheme();
            }else {
              context.bloc<ThemeBloc>().add(ThemeChanged(AppTheme.White));
              toggleTheme();
            }
          }),
          FlatButton.icon(
              onPressed: () {
                context.bloc<MusicListBloc>().add(FetchFromDB());
              },
              icon: Icon(
                Icons.get_app,
                color: Theme.of(context).accentColor,
              ),
              label: Text(
                'Check',
                style: TextStyle(color: Theme.of(context).accentColor),
              )),
          FlatButton.icon(
              onPressed: () async {
                String dirPath = await _pickDir(context);
                context.bloc<MusicListBloc>().add(Fetch(dirPath: dirPath));
              },
              icon: Icon(Icons.add, color: Theme.of(context).accentColor),
              label: Text('Folder',
                  style: TextStyle(color: Theme.of(context).accentColor)))
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: BlocBuilder<MusicListBloc, MusicListState>(
        builder: (context, state) {
          if (state is Loaded) {
            var list = state.musicList;
            return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return _createSongTile(context, list[index], index);
                });
          } else if (state is LoadingState) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.amber,
            ));
          } else {
            return Center(child: Text('fail'));
          }
        },
      ),
    );
  }

  Widget _createSongTile(BuildContext context, MyAudio audio, int index) {
    return ListTile(
      title: Text(audio.name, style: TextStyle(color: Theme.of(context).accentColor)),
      onTap: () {
        context.bloc<PlayerBloc>().add(SendIndexPlayerEvent(index));
        controller.animateToPage(1,
            duration: Duration(milliseconds: 200), curve: Curves.linear);
      },
    );
  }
}
