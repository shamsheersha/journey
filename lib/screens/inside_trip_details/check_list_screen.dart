import 'package:flutter/material.dart';
import 'package:journey/db/functions/journey_db_functions.dart';
import 'package:journey/db/model/check_list_model.dart';
import 'package:journey/db/model/journey_model.dart';
import 'package:journey/fonts/fonts.dart';

class ChecklistScreen extends StatefulWidget {
  final TripModel tripModel;
  const ChecklistScreen({super.key, required this.tripModel});

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  late ValueNotifier<List<CheckList>> checkListNotifiyer;
  final formkeyCheckList = GlobalKey<FormState>();
  late TripModel tripModel;

  final addCheckListThingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    tripModel = widget.tripModel;

    checkListNotifiyer = ValueNotifier([...?tripModel.checkboxes]);
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
              'Add Your Things',
              style: bold2,
            ),
            Expanded(
              child: ValueListenableBuilder(
                  valueListenable: checkListNotifiyer,
                  builder: (context, checkList, child) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final checkListData = checkList[index];
                        bool isCheked = checkListData.checkBoxes;
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.indigo[50],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              title: Text(
                                checkListData.name,
                                style: bold1,
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        deletingCheckList(
                                            context, checkListData, index);
                                      },
                                      icon: const Icon(Icons.delete)),
                                  Checkbox(
                                    value: isCheked,
                                    onChanged: (value) {
                                      setState(() {
                                        isCheked = value!;
                                        checkListData.checkBoxes = value;
                                        var temp = TripModel(
                                            place: tripModel.place,
                                            startDate: tripModel.startDate,
                                            endDate: tripModel.endDate,
                                            budget: tripModel.budget,
                                            notes: tripModel.notes,
                                            travelMethod:
                                                tripModel.travelMethod,
                                            images: tripModel.images,
                                            checkboxes: checkList);

                                         TripModelFunctions(). toUpdateTrip(temp, tripModel.key);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: checkList.length,
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'checklist',
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.white,
                  content: SizedBox(
                    height: MediaQuery.of(context).size.height * .22,
                    width: MediaQuery.of(context).size.width * .2,
                    child: Form(
                      key: formkeyCheckList,
                      child: Column(
                        children: [
                          const Text('Add New Thing'),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: addCheckListThingController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'error';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                labelText: "Enter CheckList"),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              const Spacer(),
                              TextButton(
                                  onPressed: () async {
                                    if (formkeyCheckList.currentState!
                                        .validate()) {
                                      final name = addCheckListThingController
                                          .text
                                          .trim();
                                      final checkBox = CheckList(name: name);

                                      var temp = TripModel(
                                          place: tripModel.place,
                                          startDate: tripModel.startDate,
                                          endDate: tripModel.endDate,
                                          budget: tripModel.budget,
                                          notes: tripModel.notes,
                                          travelMethod: tripModel.travelMethod,
                                          images: tripModel.images,
                                          checkboxes:[... checkListNotifiyer.value]);
                                      
                                      temp.checkboxes ??= [];
                                      temp.checkboxes!.add(checkBox);
                                      
                                      await TripModelFunctions().toUpdateTrip(temp, tripModel.key)
                                          .then((value) {
                                        checkListNotifiyer.value.add(checkBox);
                                        checkListNotifiyer.notifyListeners();
                                        Navigator.pop(context);
                                      });
                                      addCheckListThingController.clear();
                                    }
                                  },
                                  child: Text(
                                    'Create',
                                    style: inriaGoogleFont4,
                                  )),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: inriaGoogleFont4,
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
        label: const Text(
          'Add',
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.indigo[300],
      ),
    );
  }

  void deletingCheckList(BuildContext context, CheckList checkList, int index) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Delete this item'),
          content: const Text('Are you sure?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                checkListNotifiyer.value.removeAt(index);

                var temp = TripModel(
                    place: tripModel.place,
                    startDate: tripModel.startDate,
                    endDate: tripModel.endDate,
                    budget: tripModel.budget,
                    notes: tripModel.notes,
                    travelMethod: tripModel.travelMethod,
                    images: tripModel.images,
                    checkboxes: [...checkListNotifiyer.value]);

                await TripModelFunctions().toUpdateTrip(temp, tripModel.key).then((value) {
                 
                checkListNotifiyer.notifyListeners();
                Navigator.pop(ctx);
                });

               
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
