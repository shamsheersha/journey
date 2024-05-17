import 'package:hive_flutter/adapters.dart';
part'data_model.g.dart';

@HiveType(typeId: 0)

class UserModel extends HiveObject{
  @HiveField(0)
  final String username;

  @HiveField(1)
  final String password;

  @HiveField(2)
  final String confirmPassword;

  @HiveField(3)
  final String? image;

  UserModel({required this.username,required this.password,required this.confirmPassword ,this.image});

}