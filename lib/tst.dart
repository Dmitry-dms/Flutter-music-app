import 'dart:io';
import 'package:flutter/material.dart';
import 'package:filesystem_picker/filesystem_picker.dart';


class MyApp2 extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

  static _MyAppState of(BuildContext context) {
    return context.findAncestorStateOfType<_MyAppState>();
  }
}

class _MyAppState extends State<MyApp2> {
  Brightness _brightness = Brightness.light;

  Brightness get brightness => _brightness;

  void setThemeBrightness(Brightness brightness) {
    setState(() {
      _brightness = brightness;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FileSystem Picker Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.white,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.teal,
          textTheme: ButtonTextTheme.accent,
        ),
        brightness: _brightness,
      ),
      home: DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  String dirPath;

  Future<void> _pickDir(BuildContext context) async {
    String path = await FilesystemPicker.open(
      title: 'Save to folder',
      context: context,
      rootDirectory: Directory('/storage/emulated/0/'),
      fsType: FilesystemType.folder,
      pickText: 'Save file to this folder',
    );

    setState(() {
      dirPath = path;
      print(dirPath);
    });
    var dir = Directory(dirPath);
    dir.list(followLinks: true).forEach(smth);
  }
  smth(dynamic it)  {
    if (it is File) print(it.path.substring(dirPath.length+1));
    else print('not a file');
  }
  @override
  Widget build(BuildContext context) {
    final appState = MyApp2.of(context);

    return Scaffold(
      body: Builder(
        builder: (context) => Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Theme Brightness Switch Button
                RaisedButton(
                  child: Text((appState.brightness == Brightness.light)
                      ? 'Switch to Dark theme'
                      : 'Switch to Light theme'),
                  onPressed: () {
                    appState.setThemeBrightness(
                        appState.brightness == Brightness.light
                            ? Brightness.dark
                            : Brightness.light);
                  },
                ),
                Divider(height: 60),
                // Directory picker section
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Directory Picker',
                    style: Theme.of(context).textTheme.headline,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text('$dirPath'),
                ),
                RaisedButton(
                  child: Text('Save File'),
                  onPressed:
                      () => _pickDir(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
