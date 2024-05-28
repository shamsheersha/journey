import 'package:flutter/material.dart';
import 'package:journey/fonts/fonts.dart';
import 'package:journey/screens/login_page_&_profile_page/login_screen.dart';


class OnBoardPageTwo extends StatelessWidget {
  const OnBoardPageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome aboard \nand make every \ntrip an \nunforgettable \nstory! ',
                  textAlign: TextAlign.start,
                  style: irishGoogleFont1
                ),
                Image.asset('assets/image/Wilderness-pana-removebg-preview.png',height: 300,),
              ],
            ),
          ),
          Positioned(
            bottom: 16.0, 
            right: 16.0, 
            child: GestureDetector(
              onTap: () {
                
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=> const LoginPage()));
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
