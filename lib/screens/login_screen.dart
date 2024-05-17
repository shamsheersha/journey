import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:journey/db/functions/db_functions.dart';
import 'package:journey/db/functions/journey_db_functions.dart';
import 'package:journey/db/model/data_model.dart';
import 'package:journey/fonts/Fonts.dart';
import 'package:journey/screens/main_screens/home_screen.dart';

final _formkey = GlobalKey<FormState>();

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool _isObscure = true;
  bool _isOBscure = true;
  @override
  Widget build(BuildContext context) { 
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      'Let’s finish \nsetting up your account.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.irishGrover(
                        textStyle: const TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 60,
                    backgroundImage: _image != null
                        ? FileImage(_image!) as ImageProvider
                        : const AssetImage(
                            'assets/image/user logo.png',
                          ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.indigo[300]),
                    ),
                    onPressed: () {
                      uploadImage();
                    },
                    child: Text(
                      'Upload Photo',
                      style: inriaGoogleFont,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: userNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter UserName';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'UserName',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: passwordController,
                    obscureText: _isObscure,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Password';
                      } else if (value.length != 8) {
                        return 'Password must be 8 letters';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                            icon: Icon(_isObscure
                                ? Icons.visibility
                                : Icons.visibility_off))),
                  ),

                  const SizedBox(height: 10),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: confirmPasswordController,
                    keyboardType: TextInputType.number,
                    obscureText: _isOBscure,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Confirm Password';
                      } else if (value != passwordController.text) {
                        return 'Passwords do not match';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isOBscure = !_isOBscure;
                              });
                            },
                            icon: Icon(_isOBscure
                                ? Icons.visibility
                                : Icons.visibility_off))
                        ),
                  ),
                  // Spacer(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .27,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            regLogin();
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.indigo[300]),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          child: Text(
                            'Continue',
                            style: inriaGoogleFont1,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> regLogin() async {
    final user = userNameController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();
    final image = _image?.path;

    if (_formkey.currentState!.validate()) {
      saveUserDetails(
          UserModel(username: user, password: password, image: image, confirmPassword: confirmPassword));
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) =>  HomeScreen( tripModelNotifier: tripModelNotifier,),
      ));
    }
  }

  Future<void> uploadImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile != null ? File(pickedFile.path) : null;
    });
  }
}
