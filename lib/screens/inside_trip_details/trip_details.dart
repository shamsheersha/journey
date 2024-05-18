import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:journey/db/functions/journey_db_functions.dart';
import 'package:journey/db/model/journey_model.dart';
import 'package:journey/fonts/fonts.dart';
import 'package:journey/screens/inside_trip_details/check_list_screen.dart';
import 'package:journey/screens/inside_trip_details/notes.dart';
import 'package:journey/screens/inside_trip_details/planned_to_visit_place.dart';
import 'package:journey/screens/inside_trip_details/trip_expenses_screen.dart';

class TripDetails extends StatefulWidget {
  final TripModel tripModel;
  const TripDetails({super.key, required this.tripModel});

  @override
  State<TripDetails> createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  late TripModel tripModel;
  int _selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    tripModel = widget.tripModel;
  }

  @override
  Widget build(BuildContext context) {
    final bool isExpired = tripModel.endDate.isBefore(DateTime.now());
    final bool isCurrentTrip = tripModel.startDate.isBefore(DateTime.now()) &&
        tripModel.endDate.isAfter(DateTime.now());
    final bool isFutureTrip = tripModel.startDate.isAfter(DateTime.now()) &&
        tripModel.endDate.isAfter(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Journey',
          style: irishGoogleFont,
        ),
        backgroundColor: Colors.indigo[300],
        
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30))),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(200),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'To ${tripModel.place}',
                          style: bold1,
                        ),
                        if (isExpired)  Text('Expired Trip',style: tripExpiredFont,),
                        if (isFutureTrip)  Text('Yet to complete',style: yetToCompleteFont,),
                        if (isCurrentTrip)  Text('Current Trip',style: currentTripFont,),

                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Starting Date:',
                          style: inriaGoogleFont4,
                        ),
                        const Text('---'),
                        Text(DateFormat('MMMM-dd-yyyy')
                            .format(tripModel.startDate))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Ending Date:'),
                        const Text('   ---'),
                        Text(DateFormat('MMMM-dd-yyyy')
                            .format(tripModel.endDate))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Budget'),
                        const Text('---'),
                        Text('₹${tripModel.budget}')
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Travel Method:'),
                        Icon(getTravelModeIcon(tripModel.travelMethod))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 202, 208, 245),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          VisitingPlaces(
            tripModelNotifier: tripModelNotifier,
            tripModel: tripModel,
          ),
          ExpensesScreen(
            tripModel: tripModel,
            tripModelNotifier: tripModelNotifier,
          ),
          const Notes(),
          const ChecklistScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money_outlined),
            label: 'Expenses',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.notes_rounded), label: 'Notes'),
          BottomNavigationBarItem(
              icon: Icon(Icons.checklist), label: 'Checklist'),
        ],
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.amber,
      ),
    );
  }

  IconData getTravelModeIcon(String travelMode) {
    switch (travelMode.toLowerCase()) {
      case 'car':
        return Icons.directions_car;
      case 'train':
        return Icons.train;
      case 'bus':
        return Icons.directions_bus;
      case 'flight':
        return Icons.airplanemode_active;

      default:
        return Icons.error;
    }
  }
}
