import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/providers/datetime_provider.dart';
import 'package:front/providers/places_provider.dart';
import 'package:front/screens/home_screen.dart';

final placesNotifierProvider =
    StateNotifierProvider<PlacesNotifier, Places>((ref) {
  return PlacesNotifier();
});

final itineraryNotifierProvider =
    StateNotifierProvider<ItineraryNotifier, Itinerary>((ref) {
  return ItineraryNotifier();
});

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(title: 'Get started'),
    );
  }
}
