import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/main.dart';
import 'package:front/screens/save_screen.dart';
import 'package:front/services/place_api_service.dart';
import 'package:front/widgets/route_bottom_app_bar.dart';
import 'package:intl/intl.dart';

String formatTravelTime(String time) {
  List<String> stayTimeComponents = time.split(":");
  int hours = int.parse(stayTimeComponents[0]);
  int minutes = int.parse(stayTimeComponents[1]);
  if (hours == 0) {
    return "（$minutes minutes）";
  }
  return "（$hours hour $minutes minutes）";
}

class RouteScreen extends StatelessWidget {
  final String tripId;
  RouteScreen({super.key, required this.tripId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Route Screen'),
      ),
      bottomNavigationBar: const RouteScreenBottomBar(
        buttonText: 'Confirm & Save',
        nextPage: SaveScreen(title: 'Save Screen'),
      ),
      body: Consumer(builder: (context, ref, child) {
        final startTime = ref.read(itineraryNotifierProvider).startTime;
        final endTime = ref.read(itineraryNotifierProvider).endTime;
        return FutureBuilder(
            future: getDestinations(tripId),
            builder: (BuildContext context,
                AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasData) {
                List<Map<String, dynamic>> destinations = snapshot.data!;
                return Container(
                  padding: const EdgeInsets.all(32.0),
                  child: ListView.builder(
                    itemCount: destinations.length,
                    itemBuilder: (BuildContext context, int index) {
                      String stayTime =
                          formatTravelTime(destinations[index]['stay_time']);
                      final arrivalTime = destinations[index]['arrival_time'];
                      final departureTime =
                          destinations[index]['departure_time'];
                      final nextDestinationTravelTime =
                          destinations[index]['next_destination_travel_time'];
                      return Container(
                        height: 150,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 50,
                              child: (index != destinations.length - 1)
                                  ? Column(children: [
                                      arrivalTime == null
                                          ? Text(startTime)
                                          : Text(DateFormat('HH:mm').format(
                                              DateTime.parse(arrivalTime))),
                                      departureTime == null
                                          ? Text(endTime)
                                          : Text(DateFormat('HH:mm').format(
                                              DateTime.parse(departureTime))),
                                    ])
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                          arrivalTime == null
                                              ? Text(startTime)
                                              : Text(DateFormat('HH:mm').format(
                                                  DateTime.parse(arrivalTime))),
                                          departureTime == null
                                              ? Text(endTime)
                                              : Text(DateFormat('HH:mm').format(
                                                  DateTime.parse(
                                                      departureTime))),
                                        ]),
                            ),
                            (index != destinations.length - 1)
                                ? Stack(
                                    children: [
                                      Container(
                                        width: 1,
                                        height: 150,
                                        color: Colors.black,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                      ),
                                      Positioned.fill(
                                        top: 7,
                                        child: Align(
                                          alignment: Alignment.topCenter,
                                          child: Container(
                                            padding: EdgeInsets.only(top: 10),
                                            width: 20,
                                            height: 20,
                                            decoration: const BoxDecoration(
                                              border: Border.fromBorderSide(
                                                BorderSide(
                                                    color: Colors.black,
                                                    width: 2),
                                              ),
                                              color: Color(0xffffffff),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Stack(
                                    children: [
                                      Container(
                                        width: 1,
                                        color: Colors.white,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                      ),
                                      Positioned.fill(
                                        child: Align(
                                          alignment: Alignment.topCenter,
                                          child: Container(
                                            padding: EdgeInsets.only(top: 10),
                                            width: 20,
                                            height: 20,
                                            decoration: const BoxDecoration(
                                              border: Border.fromBorderSide(
                                                BorderSide(
                                                    color: Colors.black,
                                                    width: 2),
                                              ),
                                              color: Color(0xffffffff),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.only(top: 6.0),
                                    child: Text(
                                        '${destinations[index]["name"]}${stayTime}'),
                                  )),
                                  Expanded(
                                      child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Row(children: [
                                            (index != destinations.length - 1)
                                                ? Icon(Icons.drive_eta)
                                                : Text(''),
                                            nextDestinationTravelTime == null
                                                ? Text('')
                                                : Text(formatTravelTime(
                                                    nextDestinationTravelTime)),
                                          ])))
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            });
      }),
    );
  }
}
