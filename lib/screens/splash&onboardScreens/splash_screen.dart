import 'package:flutter/material.dart';

import 'package:journey/db/functions/db_functions.dart';
import 'package:journey/db/functions/journey_db_functions.dart';

import 'package:journey/screens/main_screens/home_screen.dart';
import '../../../fonts/Fonts.dart';
import 'package:journey/screens/splash&onboardScreens/onboard_screen1.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    toOnboardPage();

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/image/Travel.png'),
            Text('Journey',style:irishGoogleFont)
          ],
        ),
      ),
    );
  }
  Future <void> toOnboardPage()async {
  await Future.delayed( const Duration(seconds: 3));
  
  bool logged = await checkUserLoggedIn();
  if(logged)
  {
    await getUserDetails();
    await getAllTrip();
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>   HomeScreen(tripModelNotifier: tripModelNotifier,)));
  }
  else {
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=> const OnBoardPageOne()));
  }
  }
  
}


