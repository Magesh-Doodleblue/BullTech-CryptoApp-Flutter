// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages
import 'package:bulltech/screens/homepage_screen.dart';
import 'package:bulltech/screens/navigation_screen_home.dart';
import 'package:bulltech/screens/signup_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'opening_loading_screen.dart';
import 'package:firebase_core/firebase_core.dart';

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
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        // textTheme: GoogleFonts.adventProTextTheme(
        //   Theme.of(context).textTheme,
        // ),
      ),
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
              return const LoadingPage();
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
