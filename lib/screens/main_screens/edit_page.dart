import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:journey/db/functions/journey_db_functions.dart';
import 'package:journey/db/model/journey_model.dart';
import 'package:journey/fonts/Fonts.dart';

class EditTrip extends StatefulWidget {
  final TripModel tripModel;

  const EditTrip({super.key, required this.tripModel});

  @override
  State<EditTrip> createState() => _EditTripState();
}

class _EditTripState extends State<EditTrip> {
  final taskFormKeyEdit = GlobalKey<FormState>();
  DateTime? startdate = DateTime.now();
  DateTime? enddate = DateTime.now();
  final editPlaceController = TextEditingController();
  final editStartingDateController = TextEditingController();
  final editEndingDateController = TextEditingController();
  final editBudgetController = TextEditingController();
  final editNoteController = TextEditingController();
  late TripModel tripModel;
  bool isFlightSelected = false;
  bool isTrainSelected = false;
  bool isCarSelected = false;

  List<XFile> selectedImages = [];

  @override
  void initState() {
    super.initState();
    tripModel = widget.tripModel;
    editPlaceController.text = tripModel.place;
    startdate = tripModel.startDate;
    enddate = tripModel.endDate;
    editStartingDateController.text =
        DateFormat('dd-MM-yyyy').format(tripModel.startDate);
    editEndingDateController.text =
        DateFormat('dd-MM-yyyy').format(tripModel.endDate);
    editBudgetController.text = tripModel.budget;
    editNoteController.text = tripModel.notes;
    if (tripModel.travelMethod == 'Flight') {
      isFlightSelected = true;
    } else if (tripModel.travelMethod == 'Car') {
      isCarSelected = true;
    } else {
      isTrainSelected = true;
    }
  }

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
              key: taskFormKeyEdit,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Edit the trip',
                    style: inriaGoogleFont3,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: editPlaceController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
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
                    controller: editStartingDateController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
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
                          initialDate: tripModel.startDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));

                      if (startdate != null) {
                        setState(() {
                          editStartingDateController.text =
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
                    controller: editEndingDateController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
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
                          initialDate: tripModel.endDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));

                      if (enddate != null) {
                        setState(() {
                          editEndingDateController.text =
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
                    controller: editBudgetController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
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
                    controller: editNoteController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
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
                          child: Image.file(
                            File(selectedImages[index].path),
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
          saveTaskDetails(context);
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
    final List<XFile> image =
        await ImagePicker().pickMultiImage(imageQuality: 50);

    if (image.isNotEmpty) {
      setState(() {
        selectedImages.addAll(image);
      });
    }
  }

  Future saveTaskDetails(context) async {
    final place = editPlaceController.text.trim();
    final startDate = startdate;
    final endDate = enddate;
    final budget = editBudgetController.text.trim();
    final notes = editNoteController.text.trim();

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

    final editTripDetails = TripModel(
      place: place,
      startDate: startDate!,
      endDate: endDate!,
      budget: budget,
      notes: notes,
      travelMethod: travelMethod,
      images: selectedImages.map((image) => image.path).toList(),
    );

    await toUpdateTrip(editTripDetails, tripModel.key);
    tripModelNotifier.notifyListeners();

    Navigator.of(context).pop();
  }
}
