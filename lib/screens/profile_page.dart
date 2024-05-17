import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:journey/db/functions/db_functions.dart';
import 'package:journey/db/functions/journey_db_functions.dart';
import 'package:journey/db/model/data_model.dart';
import 'package:journey/fonts/fonts.dart';

class ProfileScreen extends StatefulWidget {
 final UserModel usermodel;
 const ProfileScreen({required this.usermodel, super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final editUserNameController = TextEditingController();
  late UserModel usermodel;
  int inProgressCount = 0;
  int yetToCompleteCount = 0;
  int completedCount = 0;
  String? _image;
  @override
  void initState() {
    super.initState();
    usermodel = widget.usermodel;
    _image=usermodel.image;
    calculateTripCounts();
  }

  
  final ImagePicker _picker = ImagePicker();
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              ValueListenableBuilder(
                valueListenable: userModelNotifier,
                builder: (context, data, child) {
                  return Column(
                    children: [
                      Stack(
                        children: [
                          data.image!= null
                              ? GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        surfaceTintColor: Colors.transparent,
                                        backgroundColor: Colors.transparent,
                                        content: Container(
                                          height: 300,
                                          width: 300,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: _image != null
                                                  ? FileImage(File(_image!))
                                                  : const AssetImage(
                                                      'assets/image/user logo.png',
                                                    ) as ImageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: CircleAvatar(
                                    radius: 60,
                                    backgroundImage:
                                        FileImage(File(data.image!)),
                                  ),
                                )
                              : const CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.white,
                                  backgroundImage: AssetImage(
                                    'assets/image/user logo.png',
                                  ),
                                ),
                          Positioned(
                              bottom: 5,
                              right: 8,
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.grey[350],
                              )),
                          Positioned(
                            bottom: -7,
                            right: -4,
                            child: IconButton(
                              onPressed: () {
                                uploadImage();
                              },
                              icon: const Icon(
                                Icons.camera_alt,
                                size: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(color: Colors.black,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data.username,
                            style: inriaGoogleFont2,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: IconButton(
                                onPressed: () {
                                  editUserName(context);
                                },
                                icon: const Icon(
                                  Icons.edit_square,
                                  size: 15,
                                )),
                          ),
                        ],
                      ),
                      const Divider(color: Colors.black,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'OverView',
                            style: bold,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 100,
                              width: 120,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '$inProgressCount',
                                    style: bold,
                                  ),
                                  Text('In Progress', style: inriaGoogleFont4)
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 100,
                              width: 120,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '$yetToCompleteCount',
                                    style: bold,
                                  ),
                                  Text('Yet To Complete', style: inriaGoogleFont4)
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 100,
                              width: 120,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '$completedCount',
                                    style: bold,
                                  ),
                                  Text(
                                    'Completed',
                                    style: inriaGoogleFont4,
                                  )
                                ],
                              ),
                            ),
                          ]),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> uploadImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile?.path;
    });
    final usermodelEdited = UserModel(
        username: usermodel.username,
        password: usermodel.password,
        confirmPassword: usermodel.confirmPassword,
        image: _image);
    toUpdateDetails(usermodelEdited, usermodel.key);
    userModelNotifier.notifyListeners();
  }

  Future<void> editUserName(BuildContext context) async {

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          'Change Username',
          style: inriaGoogleFont3,
        ),
        content: TextField(
          controller: editUserNameController,
          decoration: const InputDecoration(
            hintText: 'Edit Username',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          MaterialButton(
            onPressed: () async {
              final newUsername = editUserNameController.text.trim();
              if (newUsername.isNotEmpty && newUsername != usermodel.username) {
                await changeUsername(newUsername);
              }
              
              Navigator.pop(context);
            },
            color: Colors.indigo[300],
            textColor: Colors.white,
            child: Text(
              'Save',
              style: inriaGoogleFont,
            ),
          ),
        ],
      );
    },
  );
 }

 Future<void> changeUsername(String newUsername) async {
  final usermodelEdited = UserModel(
    username: newUsername,
    password: usermodel.password,
    confirmPassword: usermodel.confirmPassword,
    image: _image,
  );
  await toUpdateDetails(usermodelEdited, usermodel.key);
  userModelNotifier.notifyListeners();
  }

   calculateTripCounts() {
    final allTrips = tripModelNotifier.value;
    final now = DateTime.now();
    
    inProgressCount = allTrips.where((trip) => trip.startDate.isBefore(now) && trip.endDate.isAfter(now)).toList().length;
    yetToCompleteCount = allTrips.where((trip) => trip.startDate.isAfter(now)).toList().length;
    completedCount = allTrips.where((trip) => trip.endDate.isBefore(now)).toList().length;
  }
  
}
