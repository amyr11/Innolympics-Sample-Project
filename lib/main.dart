import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/constants.dart';
import 'package:flutter_boilerplate/firebase_options.dart';
import 'package:flutter_boilerplate/styles.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'routes.dart';
import 'utils/shared_pref_helper.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
    GoogleProvider(clientId: GOOGLE_CLIENT_ID),
  ]);
  FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: true);
  await SPHelper.sp.initSharedPreferences();
  await dotenv.load(fileName: ".env");
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Money Goalz',
      theme: kDarkTheme,
      routerConfig: router,
    );
  }
}