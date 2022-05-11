// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'options.dart';
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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCQhBh1eubfUFDFGv-cmTcSfivy9avnp9U',
    appId: '1:511093487055:web:37d2f8e4c960708add8eba',
    messagingSenderId: '511093487055',
    projectId: 'comettools-lunasea',
    authDomain: 'comettools-lunasea.firebaseapp.com',
    databaseURL: 'https://comettools-lunasea.firebaseio.com',
    storageBucket: 'comettools-lunasea.appspot.com',
    measurementId: 'G-FC3YRSW4J0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC8ZmTi02I5bbQPqW_pco-JPUt--0MvmUA',
    appId: '1:511093487055:android:dbc5731e7396ccbddd8eba',
    messagingSenderId: '511093487055',
    projectId: 'comettools-lunasea',
    databaseURL: 'https://comettools-lunasea.firebaseio.com',
    storageBucket: 'comettools-lunasea.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC94D7Hzn51z7l-2xhsaPgytfDn3VnpGZQ',
    appId: '1:511093487055:ios:97f5dc8edfc6a7c9dd8eba',
    messagingSenderId: '511093487055',
    projectId: 'comettools-lunasea',
    databaseURL: 'https://comettools-lunasea.firebaseio.com',
    storageBucket: 'comettools-lunasea.appspot.com',
    iosClientId:
        '511093487055-lnhirbi91vbrg0l3efvudgi4p04tebum.apps.googleusercontent.com',
    iosBundleId: 'app.lunasea.lunasea',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC94D7Hzn51z7l-2xhsaPgytfDn3VnpGZQ',
    appId: '1:511093487055:ios:97f5dc8edfc6a7c9dd8eba',
    messagingSenderId: '511093487055',
    projectId: 'comettools-lunasea',
    databaseURL: 'https://comettools-lunasea.firebaseio.com',
    storageBucket: 'comettools-lunasea.appspot.com',
    iosClientId:
        '511093487055-lnhirbi91vbrg0l3efvudgi4p04tebum.apps.googleusercontent.com',
    iosBundleId: 'app.lunasea.lunasea',
  );
}
