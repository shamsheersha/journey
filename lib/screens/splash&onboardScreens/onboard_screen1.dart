import 'package:flutter/material.dart';

import 'package:journey/fonts/fonts.dart';
import 'package:journey/screens/splash&onboardScreens/onboard_screen2.dart';


class OnBoardPageOne extends StatelessWidget {
  const OnBoardPageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Text(
              '"Explore the world,\none destination at a time"',
              textAlign: TextAlign.center,
              style: irishGoogleFont1
            ),
          ),
          Positioned(
            bottom: 16.0, 
            right: 16.0, 
            child: GestureDetector(
              onTap: () {
                
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=> const OnBoardPageTwo()));
              },
              child: const Text(
                'Next >>',
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
