import 'package:hive_flutter/adapters.dart';
part'expenses_model.g.dart';
@HiveType(typeId: 2)

class Expenses extends HiveObject{
  @HiveField(0)
  final String amount;

  @HiveField(1)
  final String item;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final int id;

  Expenses({required this.id, required this.amount,required this.description,required this.item});

}