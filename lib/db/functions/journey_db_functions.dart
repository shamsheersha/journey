import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:journey/db/model/journey_model.dart';

ValueNotifier<List<TripModel>> tripModelNotifier = ValueNotifier([]);
 late int currentTripKey ;
Future<void> addingTripToDb(TripModel value) async {
  final tripDb = await Hive.openBox<TripModel>('trip_db');
  final key = await tripDb.add(value);
  currentTripKey = key;
  tripModelNotifier.value.add(value);

  tripModelNotifier.notifyListeners();

  await tripDb.close();
}

Future<void> getAllTrip() async {
  final tripDb = await Hive.openBox<TripModel>('trip_db');
  tripModelNotifier.value.clear();
  tripModelNotifier.value.addAll(tripDb.values);
  tripModelNotifier.notifyListeners();
  await tripDb.close();
}

Future<void> toUpdateTrip(TripModel value, int key) async {
  final tripDb = await Hive.openBox<TripModel>('trip_db');
  await tripDb.put(key, value);
  await getAllTrip();
  await tripDb.close();
}

Future<void> deleteTrip(int id) async {
  final tripDb = await Hive.openBox<TripModel>('trip_db');
  if (tripDb.containsKey(id)) {
    await tripDb.delete(id);
    tripModelNotifier.value.clear();
    tripModelNotifier.notifyListeners();
    await getAllTrip();
  }
  await tripDb.close();
}
