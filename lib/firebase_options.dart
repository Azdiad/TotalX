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
    apiKey: 'AIzaSyD4ptv3aLu-G3iGPHvlxYQuadIJEs3RRgg',
    appId: '1:487700009264:web:48419fbde26121e79df8f5',
    messagingSenderId: '487700009264',
    projectId: 'totalxs-302f9',
    authDomain: 'totalxs-302f9.firebaseapp.com',
    storageBucket: 'totalxs-302f9.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAUOP63MMIwUhR3hT7n_HNuEeNupTHSaDA',
    appId: '1:487700009264:android:7d90882046dfc3429df8f5',
    messagingSenderId: '487700009264',
    projectId: 'totalxs-302f9',
    storageBucket: 'totalxs-302f9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAaIvclfYlqVX0Se9thRlciahhgljhNAl8',
    appId: '1:487700009264:ios:6a50342d4828c8079df8f5',
    messagingSenderId: '487700009264',
    projectId: 'totalxs-302f9',
    storageBucket: 'totalxs-302f9.appspot.com',
    iosBundleId: 'com.example.totalx',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAaIvclfYlqVX0Se9thRlciahhgljhNAl8',
    appId: '1:487700009264:ios:6a50342d4828c8079df8f5',
    messagingSenderId: '487700009264',
    projectId: 'totalxs-302f9',
    storageBucket: 'totalxs-302f9.appspot.com',
    iosBundleId: 'com.example.totalx',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD4ptv3aLu-G3iGPHvlxYQuadIJEs3RRgg',
    appId: '1:487700009264:web:a2774272c7d5b1679df8f5',
    messagingSenderId: '487700009264',
    projectId: 'totalxs-302f9',
    authDomain: 'totalxs-302f9.firebaseapp.com',
    storageBucket: 'totalxs-302f9.appspot.com',
  );

}