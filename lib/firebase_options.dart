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
    apiKey: 'AIzaSyAp-EUEHni58aNYMkWx1Rx6cZ2LynROmU4',
    appId: '1:46976336661:web:c40c300c829d8fef685f1c',
    messagingSenderId: '46976336661',
    projectId: 'coinone-e5de1',
    authDomain: 'coinone-e5de1.firebaseapp.com',
    databaseURL: 'https://coinone-e5de1-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'coinone-e5de1.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBhA3GBeB4zR6fc7kpamMTLm-PMERdXEKc',
    appId: '1:46976336661:android:017bafa029ef0f5c685f1c',
    messagingSenderId: '46976336661',
    projectId: 'coinone-e5de1',
    databaseURL: 'https://coinone-e5de1-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'coinone-e5de1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC4p0UDgwQs9FNTzgH-eWp7C50-Y0FhqG4',
    appId: '1:46976336661:ios:731e8f0b85a3bd26685f1c',
    messagingSenderId: '46976336661',
    projectId: 'coinone-e5de1',
    databaseURL: 'https://coinone-e5de1-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'coinone-e5de1.appspot.com',
    iosBundleId: 'com.example.coinOne',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC4p0UDgwQs9FNTzgH-eWp7C50-Y0FhqG4',
    appId: '1:46976336661:ios:731e8f0b85a3bd26685f1c',
    messagingSenderId: '46976336661',
    projectId: 'coinone-e5de1',
    databaseURL: 'https://coinone-e5de1-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'coinone-e5de1.appspot.com',
    iosBundleId: 'com.example.coinOne',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAp-EUEHni58aNYMkWx1Rx6cZ2LynROmU4',
    appId: '1:46976336661:web:a0b0c2933c0ccc6d685f1c',
    messagingSenderId: '46976336661',
    projectId: 'coinone-e5de1',
    authDomain: 'coinone-e5de1.firebaseapp.com',
    databaseURL: 'https://coinone-e5de1-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'coinone-e5de1.appspot.com',
  );
}
