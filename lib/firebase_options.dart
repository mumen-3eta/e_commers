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
    apiKey: 'AIzaSyBfVtS4snl_VTQD6z72VM_IUm5ozbuBnyg',
    appId: '1:966019813567:web:8b7a9267a202c604ef360a',
    messagingSenderId: '966019813567',
    projectId: 'ecommerce-app-15ab7',
    authDomain: 'ecommerce-app-15ab7.firebaseapp.com',
    storageBucket: 'ecommerce-app-15ab7.appspot.com',
    measurementId: 'G-942L7GW4K9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCYRUHT9zeBB0OTdVNEauUXC0BH4d5MUpQ',
    appId: '1:966019813567:android:0c87147eb76a09c1ef360a',
    messagingSenderId: '966019813567',
    projectId: 'ecommerce-app-15ab7',
    storageBucket: 'ecommerce-app-15ab7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDwUs9zDvPG7bKk2p5Yzw99UxZ0tunOSiY',
    appId: '1:966019813567:ios:4931ec53512a48eeef360a',
    messagingSenderId: '966019813567',
    projectId: 'ecommerce-app-15ab7',
    storageBucket: 'ecommerce-app-15ab7.appspot.com',
    iosClientId: '966019813567-6j6i0oqakv0hor54s68qqun0c31qkunp.apps.googleusercontent.com',
    iosBundleId: 'com.example.eCommers',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDwUs9zDvPG7bKk2p5Yzw99UxZ0tunOSiY',
    appId: '1:966019813567:ios:4931ec53512a48eeef360a',
    messagingSenderId: '966019813567',
    projectId: 'ecommerce-app-15ab7',
    storageBucket: 'ecommerce-app-15ab7.appspot.com',
    iosClientId: '966019813567-6j6i0oqakv0hor54s68qqun0c31qkunp.apps.googleusercontent.com',
    iosBundleId: 'com.example.eCommers',
  );
}
