import 'package:flutter/material.dart';
import 'package:journey/db/model/journey_model.dart';
import 'package:intl/intl.dart';
import 'package:journey/fonts/fonts.dart';
import 'package:journey/screens/inside_trip_details/trip_details.dart';

class CustomSearchDelegate extends SearchDelegate {
  final ValueNotifier<List<TripModel>> tripModelNotifier;

  CustomSearchDelegate(this.tripModelNotifier);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
          onPressed: () {
            query = '';
            Navigator.pop(context);
          },
          icon: const Icon(Icons.clear),
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final filteredResults = tripModelNotifier.value
        .where((element) =>
            element.place.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return _buildTripList(filteredResults);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final filteredResults = tripModelNotifier.value
        .where((element) =>
            element.place.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (filteredResults.isEmpty) {
      return const Center(child: Text('No Data'));
    }

    return _buildTripList(filteredResults);
  }

  Widget _buildTripList(List<TripModel> trips) {
    return ListView.builder(
      itemCount: trips.length,
      itemBuilder: (context, index) {
        final TripModel trip = trips[index];

        final startDateFormatted =
            DateFormat.MMMd().format(trip.startDate); // Format start date
        final endDateFormatted =
            DateFormat.MMMd().format(trip.endDate); // Format end date

        final bool isExpired = trip.endDate.isBefore(DateTime.now());
        final bool isCurrentTrip = trip.startDate.isBefore(DateTime.now()) &&
            trip.endDate.isAfter(DateTime.now());
        final bool isFutureTrip = trip.startDate.isAfter(DateTime.now()) && trip.endDate.isAfter(DateTime.now());

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 72,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.indigo[50],
              borderRadius: BorderRadius.circular(10),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => TripDetails(
                              tripModel: trip,
                            )));
              },
              child: ListTile(
                title: Text('To ${trip.place}'),
                subtitle: Text('$startDateFormatted - $endDateFormatted'),
                trailing: isExpired? 
                 Text('Trip Expired',style: tripExpiredFont,):
                isCurrentTrip ?
                 Text('Current Trip',style: currentTripFont,): 
                isFutureTrip? 
                 Text('Yet to complete',style: yetToCompleteFont,): null
              ),
            ),
          ),
        );
      },
    );
  }
}
