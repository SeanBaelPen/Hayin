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
    apiKey: 'AIzaSyC1AZtV0TWAMUhDr0Z8_mBZanm8RP7tWVE',
    appId: '1:85833995389:web:7819b4332d75ee83014d14',
    messagingSenderId: '85833995389',
    projectId: 'users-30258',
    authDomain: 'users-30258.firebaseapp.com',
    storageBucket: 'users-30258.appspot.com',
    measurementId: 'G-NYJ4VDE507',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBRyO7kz6JBC7FB9njJWMV29gxqJ2HHGzo',
    appId: '1:85833995389:android:060c49f40a7cd8b0014d14',
    messagingSenderId: '85833995389',
    projectId: 'users-30258',
    storageBucket: 'users-30258.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAHSjKTnDTLfnlmPYRYLFjYWxuRKhu_FTY',
    appId: '1:85833995389:ios:23f35ca834187158014d14',
    messagingSenderId: '85833995389',
    projectId: 'users-30258',
    storageBucket: 'users-30258.appspot.com',
    iosClientId: '85833995389-282mehnpmqh45nv3dg7ighoqmcpueljd.apps.googleusercontent.com',
    iosBundleId: 'com.example.app',
  );
}
