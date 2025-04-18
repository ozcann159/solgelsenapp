// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyDYyecLwwtZ_vwtXi0soJpatLXwqS1pFPI',
    appId: '1:812156076823:web:a0917f1ca14a2045146d52',
    messagingSenderId: '812156076823',
    projectId: 'solgensenapp',
    authDomain: 'solgensenapp.firebaseapp.com',
    storageBucket: 'solgensenapp.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBCTlSxCovTkB9Xp3knR8OkT39dsck0dtw',
    appId: '1:812156076823:android:6e9bc4f3bd84c873146d52',
    messagingSenderId: '812156076823',
    projectId: 'solgensenapp',
    storageBucket: 'solgensenapp.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDZLB5afyIjH86fSYSQi8UjXiy04EXpIwk',
    appId: '1:812156076823:ios:922ef9ff76e9d3ce146d52',
    messagingSenderId: '812156076823',
    projectId: 'solgensenapp',
    storageBucket: 'solgensenapp.firebasestorage.app',
    iosBundleId: 'com.develif.app.solgensenapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDZLB5afyIjH86fSYSQi8UjXiy04EXpIwk',
    appId: '1:812156076823:ios:922ef9ff76e9d3ce146d52',
    messagingSenderId: '812156076823',
    projectId: 'solgensenapp',
    storageBucket: 'solgensenapp.firebasestorage.app',
    iosBundleId: 'com.develif.app.solgensenapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDYyecLwwtZ_vwtXi0soJpatLXwqS1pFPI',
    appId: '1:812156076823:web:b5a66949184977ed146d52',
    messagingSenderId: '812156076823',
    projectId: 'solgensenapp',
    authDomain: 'solgensenapp.firebaseapp.com',
    storageBucket: 'solgensenapp.firebasestorage.app',
  );
}
