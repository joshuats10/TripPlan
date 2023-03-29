import 'package:flutter/material.dart';
import 'package:front/screens/save_screen.dart';
import 'package:front/services/place_api_service.dart';
import 'package:front/widgets/route_bottom_app_bar.dart';

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
      body: FutureBuilder(
          future: getDestinations(tripId),
          builder: (BuildContext context,
              AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData) {
              List<Map<String, dynamic>> destinations = snapshot.data!;
              return Container(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount: destinations.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      minVerticalPadding: 0,
                      leading: Text(destinations[index]['stay_time']),
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: 1,
                                height: 100,
                                color: Colors.black,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 12),
                              ),
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: const BoxDecoration(
                                      border: Border.fromBorderSide(
                                        BorderSide(
                                            color: Colors.black, width: 2),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(destinations[index]['name']),
                                Text(destinations[index]
                                    ['next_destination_mode']),
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
          }),
    );
  }
}
