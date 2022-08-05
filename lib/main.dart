import 'package:flutter/material.dart';
import 'package:keep_track_toolkit/landing_page.dart';

void main() {
  runApp(const KeepTrackToolkitApp());
}

class KeepTrackToolkitApp extends StatelessWidget {
  const KeepTrackToolkitApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Keep Track Toolkit',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LandingPage(),
    );
  }
}
