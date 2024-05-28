// ignore: file_names
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:journey/db/functions/journey_db_functions.dart';
import 'package:journey/db/model/journey_model.dart';
import 'package:journey/fonts/Fonts.dart';
import 'package:journey/screens/main_screens/add_trip/delete_image_while_adding.dart';
import 'package:journey/screens/main_screens/home_screen.dart';

class AddTrip extends StatefulWidget {
  const AddTrip({super.key});

  @override
  State<AddTrip> createState() => _AddTripState();
}

class _AddTripState extends State<AddTrip> {
  final taskFormKey = GlobalKey<FormState>();
  late int editKey;
  DateTime? startdate = DateTime.now();
  DateTime? enddate = DateTime.now();
  final placeController = TextEditingController();
  final startingDateController = TextEditingController();
  final endingDateController = TextEditingController();
  final budgetController = TextEditingController();
  final noteController = TextEditingController();

  bool isFlightSelected = false;
  bool isTrainSelected = false;
  bool isCarSelected = false;

  List<File> selectedImages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Journey',
          style: irishGoogleFont,
        ),
        backgroundColor: Colors.indigo[300],
      ),
      backgroundColor: Colors.indigo[100],
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: taskFormKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Plan a new trip',
                    style: inriaGoogleFont3,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: placeController,
                    validator: (value) {
                      final finalValue = value?.trim();
                      if (finalValue == null || finalValue.isEmpty) {
                        return 'Enter Destination';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        prefixIcon: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.location_pin),
                            )
                          ],
                        ),
                        labelText: 'Destination',
                        labelStyle: inriaGoogleFont4,
                        border: const OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: startingDateController,
                    validator: (value) {
                      final finalValue = value?.trim();
                      if (finalValue == null || finalValue.isEmpty) {
                        return 'Enter Starting Date';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        prefixIcon: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.date_range_outlined),
                            )
                          ],
                        ),
                        labelText: 'Start Date',
                        labelStyle: inriaGoogleFont4,
                        border: const OutlineInputBorder()),
                    onTap: () async {
                      startdate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2101));

                      if (startdate != null) {
                        setState(() {
                          startingDateController.text =
                              DateFormat('dd-MM-yyyy').format(startdate!);
                        });
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: endingDateController,
                    validator: (value) {
                      final finalValue = value?.trim();
                      if (finalValue == null || finalValue.isEmpty) {
                        return 'Enter Ending Date';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        prefixIcon: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.date_range_outlined),
                            )
                          ],
                        ),
                        labelText: 'End Date',
                        labelStyle: inriaGoogleFont4,
                        border: const OutlineInputBorder()),
                    onTap: () async {
                      enddate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2101));

                      if (enddate != null) {
                        setState(() {
                          endingDateController.text =
                              DateFormat('dd-MM-yyyy').format(enddate!);
                        });
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: budgetController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      final finalValue = value?.trim();
                      if (finalValue == null || finalValue.isEmpty) {
                        return 'Enter Budget';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        prefixIcon: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.monetization_on_outlined),
                            )
                          ],
                        ),
                        labelText: 'Budget',
                        labelStyle: inriaGoogleFont4,
                        border: const OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: noteController,
                    validator: (value) {
                      final finalValue = value?.trim();
                      if (finalValue == null || finalValue.isEmpty) {
                        return 'Enter Notes';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.edit),
                          ),
                        ],
                      ),
                      labelText: 'Notes',
                      labelStyle: inriaGoogleFont4,
                      border: const OutlineInputBorder(),
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text('Way of Travel', style: inriaGoogleFont2),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isFlightSelected = !isFlightSelected;
                            if (isFlightSelected) {
                              isTrainSelected = false;
                              isCarSelected = false;
                            }
                          });
                        },
                        child: Container(
                          height: 30,
                          width: 60,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: isFlightSelected
                                    ? Colors.blue
                                    : Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(Icons.flight_rounded,
                              color: isFlightSelected ? Colors.blue : null),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isTrainSelected = !isTrainSelected;
                            if (isTrainSelected) {
                              isFlightSelected = false;
                              isCarSelected = false;
                            }
                          });
                        },
                        child: Container(
                          height: 30,
                          width: 60,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  isTrainSelected ? Colors.blue : Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.train_outlined,
                            color: isTrainSelected ? Colors.blue : null,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isCarSelected = !isCarSelected;
                            if (isCarSelected) {
                              isFlightSelected = false;
                              isTrainSelected = false;
                            }
                          });
                        },
                        child: Container(
                          width: 60,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isCarSelected ? Colors.blue : Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.directions_car,
                            color: isCarSelected ? Colors.blue : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black),
                          onPressed: () {
                            pickImage();
                          },
                          child: Text(
                            'Add Images',
                            style: inriaGoogleFont4,
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisExtent: 130.0,
                        crossAxisSpacing: 4.0,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {},
                          onLongPress: (){
                            DeleteImage.deleteImageWhileAddingTrip(context, index,selectedImages, onImageDeleted);
                          },
                          child: Image.file(
                            selectedImages[index],
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                      itemCount: selectedImages.length,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          saveTaskDetails();
        },
        backgroundColor: Colors.indigo[300],
        child: const Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<void> pickImage() async {
    final List<XFile> images = await ImagePicker().pickMultiImage(imageQuality: 50);

    if (images.isNotEmpty) {
      setState(() {
        
        selectedImages.addAll(images.map((xfile) => File(xfile.path)).toList());
      });
    }
  }

  Future saveTaskDetails() async {
    final place = placeController.text.trim();
    final startDate = startdate;
    final endDate = enddate;
    final budget = budgetController.text.trim();
    final notes = noteController.text.trim();

    String travelMethod = '';
    if (isFlightSelected) {
      travelMethod = 'Flight';
    } else if (isTrainSelected) {
      travelMethod = 'Train';
    } else if (isCarSelected) {
      travelMethod = 'Car';
    }

    if (!isFlightSelected && !isTrainSelected && !isCarSelected) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a travel mode')),
      );
      return;
    }

    if (taskFormKey.currentState!.validate()) {
      await TripModelFunctions().addingTripToDb(TripModel(
        place: place,
        startDate: startDate!,
        endDate: endDate!,
        budget: budget,
        notes: notes,
        travelMethod: travelMethod,
        images: selectedImages.map((image) => image.path).toList(),
      )).then((value) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (ctx) =>
                  HomeScreen(tripModelNotifier: tripModelNotifier)),
          (route) => false,
        );
      });
    }
  }

  onImageDeleted(int index) {
    setState(() {
      selectedImages.removeAt(index);
    });
  }
}
