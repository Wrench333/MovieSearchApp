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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDhkgmykvbENx3s7N2AcUbzlXuSAdHHcWU',
    appId: '1:185829770176:android:85e02e9076f0539f67be25',
    messagingSenderId: '185829770176',
    projectId: 'movie-search-app-75c7e',
    storageBucket: 'movie-search-app-75c7e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBB270giat3jmROHd3BYmJm7WmOexzwFGk',
    appId: '1:185829770176:ios:72c5e1aa9ccf4f4967be25',
    messagingSenderId: '185829770176',
    projectId: 'movie-search-app-75c7e',
    storageBucket: 'movie-search-app-75c7e.appspot.com',
    androidClientId: '185829770176-v36i5ggbuu2bk4t4ifpf8g21as1nnn2n.apps.googleusercontent.com',
    iosClientId: '185829770176-0a8li39n645np7bg17314lsshi2qdnj4.apps.googleusercontent.com',
    iosBundleId: 'com.example.movieSearchApp',
  );
}
