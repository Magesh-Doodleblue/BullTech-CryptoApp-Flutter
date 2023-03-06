// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login_screen.dart';
import '../navigation_screen_home.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(brightness: Brightness.dark),
        home: Scaffold(
          body: SizedBox(
            height: myHeight,
            width: myWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.network(
                  "https://media.tenor.com/Qzr6WpBLiEAAAAAi/technology-tech.gif",
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),
                Column(
                  children: const [
                    Text(
                      'The Future',
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Learn more about cryptocurrency, look to \nthe future in BULL CURRENCY',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: myWidth * 0.14),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreenPage()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xffFBC700),
                          borderRadius: BorderRadius.circular(50)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: myWidth * 0.05,
                            vertical: myHeight * 0.013),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Create Account',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            RotationTransition(
                                turns: AlwaysStoppedAnimation(310 / 360),
                                child: Icon(Icons.arrow_forward_rounded))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
