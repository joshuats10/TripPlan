import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:front/screens/route_screen.dart';
import 'package:front/services/place_api_service.dart';
import 'package:front/widgets/bottom_app_bar.dart';

class AttractionListScreen extends StatelessWidget {
  const AttractionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Attraction List Screen'),
        ),
        bottomNavigationBar: ListScreenBottomBar(
          buttonText: 'Optimize Itinerary',
          nextPage: RouteScreen(),
        ),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: getPlaces(),
          builder: (BuildContext context,
              AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData) {
              List<Map<String, dynamic>> places = snapshot.data!;
              return Container(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount: places.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Image.network(
                              'https://picsum.photos/seed/$index/400/300',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              places[index]['name'].toString(),
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
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
          },
        ));
  }
}
