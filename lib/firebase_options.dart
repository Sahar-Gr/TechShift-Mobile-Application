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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyARpq7bJp8qMw7y96scDEyhUi18aijeCf0',
    appId: '1:1090766392131:web:8e2f0e503312c13461fdf6',
    messagingSenderId: '1090766392131',
    projectId: 'ennakl-f27a2',
    authDomain: 'ennakl-f27a2.firebaseapp.com',
    databaseURL: 'https://ennakl-f27a2-default-rtdb.firebaseio.com',
    storageBucket: 'ennakl-f27a2.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDxX9FBxjAtZJt-l6OO2bKXy7buYl66WE8',
    appId: '1:1090766392131:android:0c75338b55624dd461fdf6',
    messagingSenderId: '1090766392131',
    projectId: 'ennakl-f27a2',
    databaseURL: 'https://ennakl-f27a2-default-rtdb.firebaseio.com',
    storageBucket: 'ennakl-f27a2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCSwltfN0yNvwq9a2yz0h7jUQDXpRW5xkc',
    appId: '1:1090766392131:ios:6d4c2569c1116efe61fdf6',
    messagingSenderId: '1090766392131',
    projectId: 'ennakl-f27a2',
    databaseURL: 'https://ennakl-f27a2-default-rtdb.firebaseio.com',
    storageBucket: 'ennakl-f27a2.appspot.com',
    iosBundleId: 'com.example.applicationpfe',
  );
}