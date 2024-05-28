import 'package:hive_flutter/adapters.dart';
part 'check_list_model.g.dart';
@HiveType(typeId: 3)
class CheckList  {
  @HiveField(0)
  String name;

  @HiveField(1)
  bool checkBoxes;

  CheckList({required this.name, this.checkBoxes = false});


}