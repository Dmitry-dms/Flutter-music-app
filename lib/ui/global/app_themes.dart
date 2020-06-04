import 'package:flutter/material.dart';

enum AppTheme {
  White,
  Black,
  Gradient
}

final appThemeData = {
  AppTheme.White: ThemeData(
    primaryColor: Colors.white,
    accentColor: Colors.black
  ),
  AppTheme.Black: ThemeData(
      primaryColor: Colors.black,
      accentColor: Colors.white
  ),
  AppTheme.Gradient: ThemeData()
};