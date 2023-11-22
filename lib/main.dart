import 'package:editor/home_screen.dart';
import 'package:editor/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const PhotoApp());
}

class PhotoApp extends StatelessWidget {
  const PhotoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      title: 'Photo App',
      home: HomeScreen(),
    );
  }
}
