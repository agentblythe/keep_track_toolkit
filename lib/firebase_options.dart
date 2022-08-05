// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBD-59Q-1QsjXEMZjiLOFPmp0DA_swld6I',
    appId: '1:221985839558:web:f37875cebe2e68c70f3ac7',
    messagingSenderId: '221985839558',
    projectId: 'keep-track-toolkit-e9b8a',
    authDomain: 'keep-track-toolkit-e9b8a.firebaseapp.com',
    storageBucket: 'keep-track-toolkit-e9b8a.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDVv4am1N_LRQ5tJr2TMpbHo6WPZq052Rc',
    appId: '1:221985839558:android:f6b048b47a4e07db0f3ac7',
    messagingSenderId: '221985839558',
    projectId: 'keep-track-toolkit-e9b8a',
    storageBucket: 'keep-track-toolkit-e9b8a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBcMdjVsd3MAi7SfntX5IA2Wx1dydVOMQs',
    appId: '1:221985839558:ios:0120497d725e49350f3ac7',
    messagingSenderId: '221985839558',
    projectId: 'keep-track-toolkit-e9b8a',
    storageBucket: 'keep-track-toolkit-e9b8a.appspot.com',
    iosClientId: '221985839558-ma7e376sgvud3g5gvbs0gqdct5iceubi.apps.googleusercontent.com',
    iosBundleId: 'com.stevenblythe.keepTrackToolkit',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBcMdjVsd3MAi7SfntX5IA2Wx1dydVOMQs',
    appId: '1:221985839558:ios:0120497d725e49350f3ac7',
    messagingSenderId: '221985839558',
    projectId: 'keep-track-toolkit-e9b8a',
    storageBucket: 'keep-track-toolkit-e9b8a.appspot.com',
    iosClientId: '221985839558-ma7e376sgvud3g5gvbs0gqdct5iceubi.apps.googleusercontent.com',
    iosBundleId: 'com.stevenblythe.keepTrackToolkit',
  );
}
