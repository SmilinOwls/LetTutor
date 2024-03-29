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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBB0vrq0-kLW08bKptaaTQO8-cK1VU7mEE',
    appId: '1:1087235243360:web:c00ff11c4a50659c7a7205',
    messagingSenderId: '1087235243360',
    projectId: 'lettutor-6546b',
    authDomain: 'lettutor-6546b.firebaseapp.com',
    storageBucket: 'lettutor-6546b.appspot.com',
    measurementId: 'G-9CQPCNDSMB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDutd8Bg2SUF-K2sAr9j2rhJohb9dDIOjc',
    appId: '1:1087235243360:android:48c94d2340279fc57a7205',
    messagingSenderId: '1087235243360',
    projectId: 'lettutor-6546b',
    storageBucket: 'lettutor-6546b.appspot.com',
  );
}
