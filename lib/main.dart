
import 'package:bulltech/presentation/screens/navigation/navigation_screen_home.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'presentation/screens/authentication/signup_screen.dart';
import 'presentation/screens/navigation/homepage_screen.dart';
import 'presentation/screens/splash_screen/opening_loading_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print(fcmToken);
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  runApp(MyApp(
    isLoggedIn: isLoggedIn,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  final bool isLoggedIn;

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
        // brightness:  Brightness.dark: Brightness.light,
        textTheme: GoogleFonts.oxygenTextTheme(
          Theme.of(context).textTheme,
        ),
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
              return isLoggedIn
                  ? const NavigationButton()
                  : const LoadingPage();
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
