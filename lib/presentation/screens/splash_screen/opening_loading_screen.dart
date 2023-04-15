import 'package:flutter/material.dart';

import 'opening_splash_screen.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  // void initState() {
  // Timer(
  //   const Duration(seconds: 3),
  //   () {
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => const Splash()));
  //   },
  // );
  //   super.initState();
  // }
  final PageController _pageController = PageController();
  double currentPage = 0;

  @override
  void initState() {
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page!;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        // backgroundColor: const Color.fromARGB(255, 255, 216, 216),
        body: PageView(
          controller: _pageController,
          children: [
            firstPage(myHeight, myWidth),
            secondPage(myHeight, myWidth),
          ],
        ),
      ),
    );
  }

  Row secondPage(double myHeight, double myWidth) {
    return Row(
      children: [
        Expanded(
            child: splashWidgetScreen(
          myHeight: myHeight,
          myWidth: myWidth,
          // currectPage: currentPage,
        )),
      ],
    );
  }

  Row firstPage(double myHeight, double myWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: SizedBox(
            height: myHeight,
            width: myWidth,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: myHeight * 0.05),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text(
                  //   currentPage.toString(),
                  //   style: const TextStyle(
                  //       fontSize: 40,
                  //       color: Colors.black,
                  //       fontWeight: FontWeight.bold),
                  // ),
                  const Spacer(
                    flex: 1,
                  ),
                  Image.asset(
                    "assets/bgBulltech.png",
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: 380,
                    fit: BoxFit.contain,
                    color: const Color.fromARGB(255, 255, 66, 66),
                  ),
                  const Spacer(
                    flex: 3,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        // alignment: Alignment.centerRight,
                        child: Image.asset(
                          "assets/swipe.png",
                          width: 170,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Text(
                            'Created by BullTech Pvt LTD.',
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 255, 66, 66),
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: myHeight * 0.030,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
