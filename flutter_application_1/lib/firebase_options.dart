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
    apiKey: 'AIzaSyA3a2Wm3sdFVgKx5pWcbE7FZNGshrIw9bM',
    appId: '1:1072495003281:web:50bd107502802139fda130',
    messagingSenderId: '1072495003281',
    projectId: 'practice-a07be',
    authDomain: 'practice-a07be.firebaseapp.com',
    storageBucket: 'practice-a07be.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB_gUo9QkyfNutsOnImdE688cRqkHub8cM',
    appId: '1:1072495003281:android:b585c94a52508e57fda130',
    messagingSenderId: '1072495003281',
    projectId: 'practice-a07be',
    storageBucket: 'practice-a07be.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDlwanzObRi8k7T7nJX5WNqULQuN6p4Qw4',
    appId: '1:1072495003281:ios:64592b8f51060623fda130',
    messagingSenderId: '1072495003281',
    projectId: 'practice-a07be',
    storageBucket: 'practice-a07be.appspot.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDlwanzObRi8k7T7nJX5WNqULQuN6p4Qw4',
    appId: '1:1072495003281:ios:7d24ef631531efd8fda130',
    messagingSenderId: '1072495003281',
    projectId: 'practice-a07be',
    storageBucket: 'practice-a07be.appspot.com',
    iosBundleId: 'com.example.flutterApplication1.RunnerTests',
  );
}
