import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:journey/db/model/check_list_model.dart';
import 'package:journey/db/model/expenses_model.dart';
import 'package:journey/db/model/journey_model.dart';
import 'package:journey/screens/splash&onboardScreens/splash_screen.dart';

import 'db/model/data_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
 if(!Hive.isAdapterRegistered(UserModelAdapter().typeId)){
  Hive.registerAdapter(UserModelAdapter());
 }
 if(!Hive.isAdapterRegistered(TripModelAdapter().typeId)){
  Hive.registerAdapter(TripModelAdapter());
 }
  if(!Hive.isAdapterRegistered(ExpensesAdapter().typeId)){
    Hive.registerAdapter(ExpensesAdapter());
  }  

  if(!Hive.isAdapterRegistered(CheckListAdapter().typeId)){
    Hive.registerAdapter(CheckListAdapter());
  }
    
 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
