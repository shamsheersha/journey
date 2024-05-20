import 'package:flutter/material.dart';
import 'package:journey/db/functions/journey_db_functions.dart';
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
            Text('Add Your Things'),
            Expanded(
              child: ValueListenableBuilder(
                  valueListenable: tripModelNotifier,
                  builder: (context, value, child) {
                    return value.isEmpty
                        ? const Center(
                            child: Opacity(
                              opacity: 0.1,
                              child: Image(
                                image: AssetImage('assets/image/97695-200.png'),
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              final data = value[index];
              
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  height: 72,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.indigo[50],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      'item:',
                                      style: bold1,
                                    ),
                                    subtitle: Text(data.budget),
                                    
                                    
                                  ),
                                ),
                              );
                            },
                            itemCount: tripModelNotifier.value.length,
                          );
                  },
                ),
            ),
          ],
        ),
      )
    );
  }
}
