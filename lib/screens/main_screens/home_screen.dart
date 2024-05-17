import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:journey/db/functions/db_functions.dart';
import 'package:journey/db/functions/journey_db_functions.dart';
import 'package:journey/db/model/journey_model.dart';
import 'package:journey/fonts/fonts.dart';
import 'package:journey/screens/main_screens/add_trip.dart';
import 'package:journey/screens/main_screens/edit_page.dart';
import 'package:journey/screens/profile_page.dart';
import 'package:journey/screens/inside_trip_details/trip_details.dart';
import 'package:journey/search_Bar/search.dart';

class HomeScreen extends StatefulWidget {
  final String? query;
  final ValueNotifier<List<TripModel>> tripModelNotifier;

  const HomeScreen({super.key, this.query, required this.tripModelNotifier});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final editingPlaceController = TextEditingController();
  late String querys;

  String edit = 'Edit';
  String delete = 'Delete';

  late List<TripModel> currentTrips;
  late List<TripModel> pastTrips;
  late List<TripModel> yetToComplete;
  @override
  void initState() {
    super.initState();
    querys = widget.query ?? '';
    filterTrips();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo[300],
          title: Text(
            'Journey',
            style: irishGoogleFont,
          ),
          actions: [
            IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(widget.tripModelNotifier),
                );
              },
              icon: const Icon(Icons.search),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: ValueListenableBuilder(
                valueListenable: userModelNotifier,
                builder: (context, data, child) {
                  return data.image != null
                      ? GestureDetector(
                          child: CircleAvatar(
                            radius: 15,
                            backgroundImage: FileImage(File(data.image!)),
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => ProfileScreen(
                                usermodel: data,
                              ),
                            ));
                          },
                        )
                      : GestureDetector(
                          child: const CircleAvatar(
                            radius: 15,
                            backgroundImage: AssetImage(
                              'assets/image/user logo.png',
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => ProfileScreen(
                                usermodel: data,
                              ),
                            ));
                          },
                        );
                },
              ),
            )
          ],
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            labelStyle: inriaGoogleFont,
            dividerColor: Colors.indigo[300],
            tabs: const [
              Tab(
                text: 'Current Trips',
              ),
              Tab(
                text: 'Yet To Complete',
              ),
              Tab(text: 'Past Trips'),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 202, 208, 245),
        body: TabBarView(
          children: [
            buildTripList(currentTrips),
            buildTripList(yetToComplete),
            buildTripList(pastTrips),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => const AddTrip()));
          },
          backgroundColor: Colors.indigo[300],
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          label: Text(
            'Add Trip',
            style: floatingActionButtonColor,
          ),
        ),
      ),
    );
  }

  Widget buildTripList(List<TripModel> trips) {
    return ValueListenableBuilder(
      valueListenable: tripModelNotifier,
      builder: (context, value, child) {
        return trips.isEmpty
            ? const Center(
                child: Opacity(
                  opacity: 0.1,
                  child: Image(image: AssetImage('assets/image/97695-200.png')),
                ),
              )
            : ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  final data = trips[index];
                  final int dataKey = data.key;

                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      height: 72,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.indigo[50],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          currentTripKey = dataKey;
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => TripDetails(
                                    tripModel: data,
                                  )));
                        },
                        child: ListTile(
                          leading: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  surfaceTintColor: Colors.transparent,
                                  backgroundColor: Colors.transparent,
                                  content: Container(
                                    height: 300,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: data.images.isNotEmpty
                                            ? FileImage(File(data.images.first))
                                            : const AssetImage(
                                                    'assets/image/gallery.png')
                                                as ImageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: CircleAvatar(
                              radius: 25,
                              backgroundImage: data.images.isNotEmpty
                                  ? FileImage(File(data.images.first))
                                  : null,
                              backgroundColor: Colors.black,
                            ),
                          ),
                          title: Text('To ${data.place}'),
                          subtitle: Text(
                            '${DateFormat('MMMM dd').format(data.startDate)} - ${DateFormat('MMMM dd').format(data.endDate)}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              PopupMenuButton(
                                color: Colors.indigo[50],
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    child: ListTile(
                                      leading: const Icon(Icons.edit),
                                      title: const Text('Edit'),
                                      onTap: () {
                                        Navigator.pop(context);
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (ctx) =>
                                                    EditTrip(tripModel: data)))
                                            .then((value) {
                                          filterTrips();
                                          setState(() {});
                                        });
                                        
                                      },
                                    ),
                                  ),
                                  PopupMenuItem(
                                    child: ListTile(
                                      leading: const Icon(Icons.delete),
                                      title: const Text('Delete'),
                                      onTap: () {
                                        Navigator.pop(
                                            context); // Close the popup menu
                                        deletingTrip(context, dataKey);
                                      },
                                    ),
                                  ),
                                ],
                              )

                              // IconButton(
                              //   onPressed: () {
                              //     Navigator.of(context)
                              //         .push(MaterialPageRoute(
                              //             builder: (ctx) =>
                              //                 EditTrip(tripModel: data)))
                              //         .then((value) {
                              //       filterTrips();
                              //       setState(() {});
                              //     });
                              //   },
                              //   icon: const Icon(Icons.edit),
                              // ),
                              // IconButton(
                              //   onPressed: () {
                              //     deletingTrip(context, dataKey);
                              //   },
                              //   icon: const Icon(Icons.delete),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: trips.length,
              );
      },
    );
  }

  deletingTrip(BuildContext context, id) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Delete this Trip'),
          content: const Text('Are you sure?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await deleteTrip(id).then((value) {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Deleted'),
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.all(20),
                    ),
                  );
                });
                filterTrips();
                setState(() {});
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  filterTrips() {
    final now = DateTime.now();
    final allTrips = tripModelNotifier.value;
    currentTrips = allTrips
        .where(
            (trip) => trip.startDate.isBefore(now) && trip.endDate.isAfter(now))
        .toList();
    pastTrips = allTrips.where((trip) => trip.endDate.isBefore(now)).toList();
    yetToComplete =
        allTrips.where((trip) => trip.startDate.isAfter(now)).toList();
  }
}
