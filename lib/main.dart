import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:keep_track_toolkit/firebase_options.dart';
import 'package:keep_track_toolkit/landing_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
