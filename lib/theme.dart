import 'package:flutter/material.dart';

final appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.teal,
  ),
);

//button style for the app
final buttonStyle = ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        const RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(10)),
)));
