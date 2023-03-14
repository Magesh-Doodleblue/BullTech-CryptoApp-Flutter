import 'package:flutter/material.dart';

SizedBox loadingWidget(double myHeight, double myWidth) {
  return SizedBox(
    height: myHeight,
    width: myWidth,
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: myHeight * 0.05),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'BULL CRYPTO',
            style: TextStyle(
                fontSize: 40, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const Spacer(
            flex: 1,
          ),
          Image.network(
            "https://media.tenor.com/Qzr6WpBLiEAAAAAi/technology-tech.gif",
            width: 280,
            height: 280,
            fit: BoxFit.contain,
          ),
          const Spacer(
            flex: 3,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text(
                    'Created by BullTech Pvt LTD.',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              SizedBox(
                height: myHeight * 0.005,
              ),
              // Image.asset(
              //   'assets/circle-loading-spin.gif',
              //   height: myHeight * 0.015,
              //   color: Colors.black,
              // ),
            ],
          ),
        ],
      ),
    ),
  );
}
