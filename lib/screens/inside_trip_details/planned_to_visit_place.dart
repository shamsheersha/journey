import 'dart:io';

import 'package:flutter/material.dart';


import 'package:journey/db/model/journey_model.dart';
import 'package:journey/fonts/fonts.dart';

class VisitingPlaces extends StatefulWidget {
  final TripModel tripModel;
  final ValueNotifier<List<TripModel>> tripModelNotifier;
  const VisitingPlaces({super.key, required this.tripModelNotifier,required this.tripModel});

  @override
  State<VisitingPlaces> createState() => _VisitingPlacesState();
}

class _VisitingPlacesState extends State<VisitingPlaces> {
  late TripModel tripModel;
  @override
  void initState() {
    super.initState();
    tripModel = widget.tripModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 202, 208, 245),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Planned To Visit',
              style: bold1,
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              
              child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisExtent: 150,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0),
              itemBuilder: ((context, index) {
                
                return GestureDetector(
                    onTap: () => tapImage(index),
                    child: Image.file(File(tripModel.images[index]),fit: BoxFit.cover,));
              }),
              itemCount:tripModel.images.length,
                              ),
            ),
          ],
        ),
      ),
    );
  }

  tapImage(int index) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            content: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: FileImage(File(tripModel.images[index])),
                    fit: BoxFit.cover),
              ),
            ),
          );
        });
  }
}
