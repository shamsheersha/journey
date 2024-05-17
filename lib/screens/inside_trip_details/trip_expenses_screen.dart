import 'package:flutter/material.dart';
import 'package:journey/db/functions/expenses_db.dart';
import 'package:journey/db/functions/journey_db_functions.dart';
import 'package:journey/db/model/expenses_model.dart';
import 'package:journey/db/model/journey_model.dart';
import 'package:journey/fonts/fonts.dart';

class ExpensesScreen extends StatefulWidget {
  final TripModel tripModel;
  final ValueNotifier<List<TripModel>> tripModelNotifier;

  const ExpensesScreen({
    super.key,
    required this.tripModel,
    required this.tripModelNotifier,
  });

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final GlobalKey<FormState> expenseFormKey = GlobalKey<FormState>();
  late TripModel tripModel;
  int totalExpenseAmount = 0;
  bool isEditing = true;
  int stringBudgetAmount = 0;

  final amountController = TextEditingController();
  final itemController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tripModel = widget.tripModel;

    getAllExpensesSample();
  }

  @override
  void dispose() {
    amountController.dispose();
    itemController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int stringBudget = int.parse(tripModel.budget);
    stringBudgetAmount = stringBudget - totalExpenseAmount;
    // String budget = stringBudget.toStringAsFixed(2);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 202, 208, 245),
      body: Padding(
        padding: const EdgeInsets.all(19.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Balance Amount:₹$stringBudgetAmount ',
                    style: bold1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Total Amount: $stringBudget',
                    style: inriaGoogleFont4,
                  ),
                ],
              ),
            ),
            Text(
              'Expenses',
              style: bold2,
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: expensesNotifier,
                builder: (context, value, child) {
                  return value.isEmpty
                      ? const Center(
                          child: Opacity(
                            opacity: 0.1,
                            child: Image(
                              image: AssetImage('assets/image/97695-200.png'),
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            final data = value[index];

                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                height: 72,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.indigo[50],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  title: Text(
                                    'item: ${data.item}',
                                    style: bold1,
                                  ),
                                  subtitle: Text(
                                    'amount: ${data.amount}',
                                    style: inriaGoogleFont4,
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              isEditing = false;
                                            });

                                            editingExpenses(context, data);
                                          },
                                          icon: const Icon(Icons.edit)),
                                      IconButton(
                                          onPressed: () {
                                            deletingExpenses(
                                                context, data, data.id);
                                          },
                                          icon: const Icon(Icons.delete)),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: expensesNotifier.value.length,
                        );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: isEditing
          ? FloatingActionButton.extended(
              onPressed: () {
                addingExpenses(context);
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              label: const Text(
                'Add Expenses',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.indigo[300],
            )
          : null,
    );
  }

  addingExpenses(BuildContext context) async {
    showBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 500,
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            color: Colors.white,
          ),
          child: ListView(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Close',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Text(
                        'Add Expenses',
                        style: inriaGoogleFont4,
                      ),
                      TextButton(
                        onPressed: () {
                          saveExpenses(context);
                        },
                        child: const Text(
                          'Done',
                          style: TextStyle(color: Colors.indigo),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key: expenseFormKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: amountController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter Amount';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              prefixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      ' ₹',
                                      style: bold1,
                                    ),
                                  ),
                                ],
                              ),
                              labelText: 'Amount',
                              labelStyle: inriaGoogleFont4,
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: itemController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter item';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.category_outlined),
                                  ),
                                ],
                              ),
                              labelText: 'Item',
                              labelStyle: inriaGoogleFont4,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: descriptionController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter Description';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.description),
                                  ),
                                ],
                              ),
                              labelText: 'Description',
                              labelStyle: inriaGoogleFont4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  saveExpenses(context) async {
    final amount = amountController.text.trim();
    final item = itemController.text.trim();
    final description = descriptionController.text.trim();
    currentTripKey = tripModel.key;
    if (expenseFormKey.currentState!.validate()) {
      final expensesDetails = Expenses(
        amount: amount,
        description: description,
        item: item,
        id: currentTripKey,
      );

      await addingExpensesToDb(expensesDetails);

      setState(() {
        totalExpenseAmount += int.parse(amount);
      });

      Navigator.of(context).pop();
    }
    amountController.clear();
    itemController.clear();
    descriptionController.clear();
  }

  getAllExpensesSample() async {
    currentTripKey = tripModel.key;
    await getAllExpenses();
    await checkingBalance();
  }

  checkingBalance() {
    totalExpenseAmount = 0;
    for (final expense in expensesNotifier.value) {
      totalExpenseAmount += int.parse(expense.amount);
    }
    stringBudgetAmount = int.parse(tripModel.budget) - totalExpenseAmount;

    setState(() {});
  }

  editingExpenses(BuildContext context, Expenses expenses) async {
    amountController.text = expenses.amount;
    itemController.text = expenses.item;
    descriptionController.text = expenses.description;

    showBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 500,
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            color: Colors.white,
          ),
          child: ListView(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          setState(() {
                            isEditing = true;
                          });
                        },
                        child: const Text(
                          'Close',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Text(
                        'Editing Expenses',
                        style: inriaGoogleFont4,
                      ),
                      TextButton(
                        onPressed: () async {
                          setState(() {
                            isEditing = true;
                          });
                          await toUpdateExpenses(
                              Expenses(
                                  id: currentTripKey,
                                  amount: amountController.text,
                                  description: descriptionController.text,
                                  item: itemController.text),
                              expenses.key);
                          await getAllExpensesSample();
                          Navigator.of(context).pop();
                          amountController.clear();
                          itemController.clear();
                          descriptionController.clear();
                        },
                        child: const Text(
                          'Done',
                          style: TextStyle(color: Colors.indigo),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key: expenseFormKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: amountController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter Amount';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              prefixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      ' ₹',
                                      style: bold1,
                                    ),
                                  ),
                                ],
                              ),
                              labelText: 'Amount',
                              labelStyle: inriaGoogleFont4,
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: itemController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter item';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.category_outlined),
                                  ),
                                ],
                              ),
                              labelText: 'Item',
                              labelStyle: inriaGoogleFont4,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: descriptionController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter Description';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.description),
                                  ),
                                ],
                              ),
                              labelText: 'Description',
                              labelStyle: inriaGoogleFont4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  deletingExpenses(BuildContext context, Expenses expenses, id) {
    showDialog(
        context: context,
        builder: (ctx) {
          final data = expenses;
          return AlertDialog(
            title: const Text('Delete this Expense'),
            content: const Text('Are you sure?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () async {
                    await deleteExpenses(data.key);
                    await getAllExpensesSample();
                    Navigator.pop(ctx);
                  },
                  child: const Text('Delete'))
            ],
          );
        });
  }
}
