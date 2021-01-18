import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wallfy/screens/homeScreen.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {



  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 1),
            () => Navigator.push(context, PageTransition(child: HomeScreen(), type: PageTransitionType.leftToRight))
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      body: Center(
        child: RichText(
          text: TextSpan(
              text: 'Wallpaper',
              style: TextStyle(

                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30
              ),
              children: <TextSpan>[
                TextSpan(
                    text: 'Hub',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 34
                    )
                )
              ]
          ),
        ),
      ),
    );
  }
}
