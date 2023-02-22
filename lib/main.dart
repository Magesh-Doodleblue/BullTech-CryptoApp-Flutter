// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages
import 'package:bulltech/signup_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homepage_screen.dart';
import 'login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'navigation_screen_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print(fcmToken);
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final bool isLoggedIn;

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/navigationbutton": (context) => const NavigationButton(),
        "/signup": (context) => const SignupScreen(),
        "/homepage": (context) => const HomePage(),
      },
      home: Scaffold(
        body: FutureBuilder(
          future: _initializeFirebase(),
          builder: (BuildContext context, AsyncSnapshot<FirebaseApp> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return const LoginScreenPage();
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
