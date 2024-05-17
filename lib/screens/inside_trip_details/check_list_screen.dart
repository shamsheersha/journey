import 'package:flutter/material.dart';
import 'package:journey/fonts/fonts.dart';

class ChecklistScreen extends StatelessWidget {
  const ChecklistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.indigo[100],
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text('CheckList:',style: bold1,),
            // Expanded(child: ValueListenableBuilder(valueListenable: , builder: builder))
          ],
        ),
      )
    );
  }
}
