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
    apiKey: 'AIzaSyDKcyvMz_O2SZe6VUBqdpktzGrebFO6ecc',
    appId: '1:795772164826:web:59266d27b62945dddce3e3',
    messagingSenderId: '795772164826',
    projectId: 'my-first-project-318fb',
    authDomain: 'my-first-project-318fb.firebaseapp.com',
    storageBucket: 'my-first-project-318fb.appspot.com',
    measurementId: 'G-ES3GHTS6KN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyApJXFbh3Ch8wm989NeJ8AX83NOTyzL3bg',
    appId: '1:795772164826:android:94f215a260562c1bdce3e3',
    messagingSenderId: '795772164826',
    projectId: 'my-first-project-318fb',
    storageBucket: 'my-first-project-318fb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDywbWG_6TcVExIF2EuE7W_Oqlcu2zG4Ko',
    appId: '1:795772164826:ios:eda0402b8b3828bcdce3e3',
    messagingSenderId: '795772164826',
    projectId: 'my-first-project-318fb',
    storageBucket: 'my-first-project-318fb.appspot.com',
    iosBundleId: 'com.example.firebaseProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDywbWG_6TcVExIF2EuE7W_Oqlcu2zG4Ko',
    appId: '1:795772164826:ios:7d6ef39d35e86a7ddce3e3',
    messagingSenderId: '795772164826',
    projectId: 'my-first-project-318fb',
    storageBucket: 'my-first-project-318fb.appspot.com',
    iosBundleId: 'com.example.firebaseProject.RunnerTests',
  );
}