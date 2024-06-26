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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAf_j56ZgLVDrMguT3t6HFYgFJj5AVS1u8',
    appId: '1:67657915045:android:5cdf50839da3fdf8ab0b4c',
    messagingSenderId: '67657915045',
    projectId: 'campus-buddy-8ee85',
    storageBucket: 'campus-buddy-8ee85.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAgU7LMfAaNzHRtBqJ-Q77gsAdtv22bTys',
    appId: '1:67657915045:ios:6f28007608b4bfabab0b4c',
    messagingSenderId: '67657915045',
    projectId: 'campus-buddy-8ee85',
    storageBucket: 'campus-buddy-8ee85.appspot.com',
    iosBundleId: 'com.campusbuddy.campusBuddy',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDF_-cCjyf4Bz3menteBJ_IllJ2lHatAuk',
    appId: '1:67657915045:web:b611bfacb703ad10ab0b4c',
    messagingSenderId: '67657915045',
    projectId: 'campus-buddy-8ee85',
    authDomain: 'campus-buddy-8ee85.firebaseapp.com',
    storageBucket: 'campus-buddy-8ee85.appspot.com',
  );
}
