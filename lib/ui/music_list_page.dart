import 'dart:io';

import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/bloc/music_list/music_list_bloc.dart';
final _bloc = MusicListBloc();
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _bloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Music list'),
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () {
                  _bloc.add(FetchFromDB());
                },
                icon: Icon(Icons.get_app),
                label: Text('Check')),
            FlatButton.icon(
                onPressed: () async {
                  String dirPath = await _pickDir(context);
                  print(dirPath);
                  //_bloc.add(Fetch(dirPath: dirPath));
                }, icon: Icon(Icons.add), label: Text('Folder'))
          ],
        ),
        body: BlocBuilder<MusicListBloc, MusicListState>(
          builder: (context, state) {
            if (state is Loaded) {
              var list = state.musicList;
              return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return Text(list[index].name);
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
      ),
    );
  }
}