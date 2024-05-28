import 'package:flutter/material.dart';
import 'package:journey/db/functions/journey_db_functions.dart';
import 'package:journey/db/model/journey_model.dart';
import 'package:journey/fonts/fonts.dart';

class Notes extends StatefulWidget {
  final TripModel tripModel;
  const Notes({super.key, required this.tripModel});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  late TripModel tripModel;
  final editNoteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tripModel = widget.tripModel;
    editNoteController.text = tripModel.notes ;
  }

  @override
  void dispose() {
    editNoteController.dispose();
    super.dispose();
  }

  Future<void> updateNoteAndUI(String note) async {
    await TripModelFunctions().updateNote(widget.tripModel.key, note);
    setState(() {
      tripModel.notes = note;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[100],
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Notes', style: bold2),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height: 420,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: editNoteController,
                      onChanged: (value) async {
                        await updateNoteAndUI(value);
                      },
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
                      ),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
