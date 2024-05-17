import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:journey/db/functions/journey_db_functions.dart';
import 'package:journey/db/model/expenses_model.dart';

ValueNotifier<List<Expenses>> expensesNotifier = ValueNotifier([]);

addingExpensesToDb(Expenses value)async{
  
  final expensesDb = await Hive.openBox<Expenses>('expenses_DB');

  expensesDb.add(value);

  expensesNotifier.value.add(value);
  getAllExpenses();
  expensesNotifier.notifyListeners();

}

Future<void> getAllExpenses() async {
  final expensesDb = await Hive.openBox<Expenses>('expenses_DB');
  expensesNotifier.value.clear();
  final allExpenses = expensesDb.values.where((expense) => expense.id == currentTripKey).toList();
  expensesNotifier.value.addAll(allExpenses);
  expensesNotifier.notifyListeners();
  await expensesDb.close();
}

Future<void> toUpdateExpenses(Expenses value, int key) async {
  final expensesDb = await Hive.openBox<Expenses>('expenses_DB');
  await expensesDb.put(key, value);
  await getAllExpenses();
  await expensesDb.close();
}

Future<void> deleteExpenses(int id) async {
  final expensesDb = await Hive.openBox<Expenses>('expenses_DB');
  if (expensesDb.containsKey(id)) {
    await expensesDb.delete(id);
    expensesNotifier.value.clear();
    expensesNotifier.notifyListeners();
    await getAllExpenses();
  }
  await expensesDb.close();
}