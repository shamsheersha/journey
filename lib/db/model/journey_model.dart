import 'package:hive_flutter/adapters.dart';
part 'journey_model.g.dart';

@HiveType(typeId: 1)
class TripModel extends HiveObject{
  @HiveField(0)
  final String place;

  @HiveField(1)
  final DateTime startDate;

  @HiveField(2)
  final DateTime endDate;

  @HiveField(3)
  final String budget;

  @HiveField(4)
    String notes;

  @HiveField(5)
  final String travelMethod;
  
  @HiveField(6)
  final List<String> images;

  @HiveField(7)
   final Map<String, bool>? checkboxes; 

  TripModel({
    required this.place,
    required this.startDate,
    required this.endDate,
    required this.budget, 
    required this.notes ,
    required this.travelMethod,
    required this.images,
     this.checkboxes, 
    });
}