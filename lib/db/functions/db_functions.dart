import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:journey/db/model/data_model.dart';

ValueNotifier<UserModel> userModelNotifier = ValueNotifier(UserModel(username: '', password: '',  confirmPassword: '',image: ''));

Future<void> saveUserDetails(UserModel value)async{
  final userDB = await Hive.openBox<UserModel>('userDetails_db');
  
  await userDB.add(value);

  userModelNotifier.value = value;
  userDB.close();

}

Future<void> getUserDetails()async{
  final userDB = await Hive.openBox<UserModel>('userDetails_db');
 

  userModelNotifier.value = userDB.values.first ;
  userDB.close();

}

Future<void> toUpdateDetails(UserModel ussermodel ,int key)async{
  final userDB = await Hive.openBox<UserModel>('userDetails_db');


  await userDB.putAt(key, ussermodel);
  userModelNotifier.value = userDB.values.first;
  userDB.close();
}



Future <bool> checkUserLoggedIn()async {
  final db = await Hive.openBox<UserModel>('userDetails_db');
  return db.isNotEmpty;
}